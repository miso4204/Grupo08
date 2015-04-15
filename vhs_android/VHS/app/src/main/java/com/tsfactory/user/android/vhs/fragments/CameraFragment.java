package com.tsfactory.user.android.vhs.fragments;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.hardware.Camera;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.SurfaceHolder;
import android.view.SurfaceHolder.Callback;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.Toast;

import com.cloudinary.Cloudinary;
import com.tsfactory.user.android.vhs.R;
import com.tsfactory.user.android.vhs.util.Constants;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link CameraFragment.OnCameraFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link CameraFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class CameraFragment extends Fragment {

    private OnCameraFragmentInteractionListener mListener;

    private final static String TAG = "CameraFragment";

    private Camera camera;
    private SurfaceView surfaceView;
    private ImageButton photoButton;


    public static CameraFragment newInstance() {
        CameraFragment fragment = new CameraFragment();
        return fragment;
    }

    public CameraFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_camera, container, false);

        photoButton = (ImageButton) v.findViewById(R.id.camera_photo_button);

        if (camera == null) {
            try {
                camera = Camera.open();
                photoButton.setEnabled(true);
            } catch (Exception e) {
                Log.e(TAG, "No camera with exception: " + e.getMessage());
                photoButton.setEnabled(false);
                Toast.makeText(getActivity(), "No camera detected",
                        Toast.LENGTH_LONG).show();
            }
        }

        photoButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                if (camera == null)
                    return;
                camera.takePicture(new Camera.ShutterCallback() {

                    @Override
                    public void onShutter() {
                        // nothing to do
                    }

                }, null, new Camera.PictureCallback() {

                    @Override
                    public void onPictureTaken(byte[] data, Camera camera) {
                        saveScaledPhoto(data);
                    }

                });

            }
        });

        surfaceView = (SurfaceView) v.findViewById(R.id.camera_surface_view);
        SurfaceHolder holder = surfaceView.getHolder();
        holder.addCallback(new Callback() {

            public void surfaceCreated(SurfaceHolder holder) {
                try {
                    if (camera != null) {
                        camera.setDisplayOrientation(90);
                        camera.setPreviewDisplay(holder);
                        camera.startPreview();
                    }
                } catch (IOException e) {
                    Log.e(TAG, "Error setting up preview", e);
                }
            }

            public void surfaceChanged(SurfaceHolder holder, int format,
                                       int width, int height) {
                // nothing to do here
            }

            public void surfaceDestroyed(SurfaceHolder holder) {
                // nothing here
            }

        });

        return v;
    }

    /*
	 * Since we never need a full-size image in our app, we'll
	 * save a scaled one right away.
	 */
    private void saveScaledPhoto(byte[] data) {

        // Resize photo from camera byte array
        Bitmap mealImage = BitmapFactory.decodeByteArray(data, 0, data.length);
        Bitmap mealImageScaled = Bitmap.createScaledBitmap(mealImage, 200, 200
                * mealImage.getHeight() / mealImage.getWidth(), false);

        // Override Android default landscape orientation and save portrait
        Matrix matrix = new Matrix();
        matrix.postRotate(90);
        Bitmap rotatedScaledMealImage = Bitmap.createBitmap(mealImageScaled, 0,
                0, mealImageScaled.getWidth(), mealImageScaled.getHeight(),
                matrix, true);

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        rotatedScaledMealImage.compress(Bitmap.CompressFormat.JPEG, 100, bos);

        //final byte[] scaledData = bos.toByteArray();

        final InputStream is = new ByteArrayInputStream(bos.toByteArray());

        // Save the scaled image to Server
        AsyncTask<Void, Void, String> task = new AsyncTask<Void, Void, String>() {

            @Override
            protected String doInBackground(Void... params) {

                Cloudinary cloudinary = new Cloudinary(Constants.CLOUDINARY_URL);
                try {
                    cloudinary.uploader().upload(is, Cloudinary.asMap("cami7ord", "sample_remote"));
                    cloudinary.url().generate("sample_remote.jpg");
                } catch (IOException e) {
                    e.printStackTrace();
                }

                return "http://res.cloudinary.com/cami7ord/image/upload/sample_remote.jpg";
            }

            @Override
            protected void onPostExecute(String url) {
                Log.e(TAG, "Image saved...");
                addPhotoToPropertyAndReturn(url);
            }
        };
        task.execute();
    }

    /*
	 * Once the photo has saved successfully, we're ready to return to the
	 * NewMealFragment. When we added the CameraFragment to the back stack, we
	 * named it "NewMealFragment". Now we'll pop fragments off the back stack
	 * until we reach that Fragment.
	 */
    private void addPhotoToPropertyAndReturn(String photoFile) {
        //((NewMealActivity) getActivity()).getCurrentMeal().setPhotoFile(photoFile);
        Log.e(TAG, "Imagen subida exitosamente");

        FragmentManager fm = getActivity().getSupportFragmentManager();
        fm.popBackStack("AddPropertyFragment",
                FragmentManager.POP_BACK_STACK_INCLUSIVE);
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onCameraFragmentInteraction(uri);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        if (camera == null) {
            try {
                camera = Camera.open();
                photoButton.setEnabled(true);
            } catch (Exception e) {
                Log.i(TAG, "No camera: " + e.getMessage());
                photoButton.setEnabled(false);
                Toast.makeText(getActivity(), "No camera detected",
                        Toast.LENGTH_LONG).show();
            }
        }
    }

    @Override
    public void onPause() {
        if (camera != null) {
            camera.stopPreview();
            camera.release();
        }
        super.onPause();
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        try {
            mListener = (OnCameraFragmentInteractionListener) activity;
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnCameraFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    public interface OnCameraFragmentInteractionListener {
        // TODO: Update argument type and name
        public void onCameraFragmentInteraction(Uri uri);
    }

}
