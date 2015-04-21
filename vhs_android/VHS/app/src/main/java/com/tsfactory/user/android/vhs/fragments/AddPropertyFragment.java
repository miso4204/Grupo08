package com.tsfactory.user.android.vhs.fragments;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;

import com.tsfactory.user.android.vhs.MainActivity;
import com.tsfactory.user.android.vhs.R;
import com.tsfactory.user.android.vhs.util.Constants;
import com.tsfactory.user.android.vhs.util.SessionManager;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;

/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link AddPropertyFragment.OnAddPropertyFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link AddPropertyFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class AddPropertyFragment extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private OnAddPropertyFragmentInteractionListener mListener;

    /**
     * The fragment argument representing the section number for this
     * fragment.
     */
    private static final String ARG_SECTION_NUMBER = "section_number";

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param sectionNumber Parameter 1.
     * @return A new instance of fragment AddPropertyFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static AddPropertyFragment newInstance(int sectionNumber) {
        AddPropertyFragment fragment = new AddPropertyFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.setArguments(args);
        return fragment;
    }

    public AddPropertyFragment() {
        // Required empty public constructor
    }

    /**
     * Keep track of the login task to ensure we can cancel it if requested.
     */
    private AddPropertyTask mPropertyTask = null;

    // UI references.
    private EditText mTitleView;
    private EditText mDescriptionView;
    private DatePicker mDatepickerView;
    private Spinner mCitySpinnerView;
    private Spinner mCategorySpinnerView;
    private EditText mPriceView;
    private Spinner mCurrencySpinnerView;
    private Button mUploadPicView;
    private String mPictureUrl;
    private Button mAddPropertyView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_add_property, container, false);

        mTitleView = (EditText) view.findViewById(R.id.property_title);
        mDescriptionView = (EditText) view.findViewById(R.id.property_description);

        mDatepickerView = (DatePicker) view.findViewById(R.id.property_date);
        initDatepicker();

        mCitySpinnerView = (Spinner) view.findViewById(R.id.property_location);
        mCategorySpinnerView = (Spinner) view.findViewById(R.id.property_category);
        mPriceView = (EditText) view.findViewById(R.id.property_price);
        mCurrencySpinnerView = (Spinner) view.findViewById(R.id.property_currency);

        mUploadPicView = (Button) view.findViewById(R.id.property_add_photo_button);
        mUploadPicView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startCamera();
            }
        });

        mAddPropertyView = (Button) view.findViewById(R.id.create_property_button);
        mAddPropertyView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String title = mTitleView.getText().toString();
                String description = mDescriptionView.getText().toString();
                double price = Double.valueOf(mPriceView.getText().toString());
                String date = mDatepickerView.getYear() + "-" + mDatepickerView.getMonth() + "-" + mDatepickerView.getDayOfMonth();
                String pictureUrl = "https://ictericiadotme.files.wordpress.com/2014/05/canopy.jpg";
                //showProgress(true);
                mPropertyTask = new AddPropertyTask(getActivity(), title, description, price, date, pictureUrl);
                mPropertyTask.execute((Void) null);
            }
        });

        setSpinnersAdapters();

        return view;
    }

    private void initDatepicker() {
        int day = mDatepickerView.getDayOfMonth();
        int month = mDatepickerView.getMonth();
        int year = mDatepickerView.getYear();
        mDatepickerView.init(year, month, day, new DatePicker.OnDateChangedListener() {
            @Override
            public void onDateChanged(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                Log.e("Date changed: ", year + " - " + monthOfYear + " - " + dayOfMonth);
            }
        });
    }

    private void setSpinnersAdapters() {

        ArrayAdapter<CharSequence> mAdapter;

        // Create an ArrayAdapter using the string array and a default spinner layout
        mAdapter = ArrayAdapter.createFromResource(getActivity(),
                R.array.city_array, android.R.layout.simple_spinner_item);
        // Specify the layout to use when the list of choices appears
        mAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

        mCitySpinnerView.setAdapter(mAdapter);

        mAdapter = ArrayAdapter.createFromResource(getActivity(),
                R.array.category_array, android.R.layout.simple_spinner_item);
        mAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        mCategorySpinnerView.setAdapter(mAdapter);

        mAdapter = ArrayAdapter.createFromResource(getActivity(),
                R.array.currency_array, android.R.layout.simple_spinner_item);
        mAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        mCurrencySpinnerView.setAdapter(mAdapter);
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        try {
            mListener = (OnAddPropertyFragmentInteractionListener) activity;

            ((MainActivity) activity).onSectionAttached(
                    getArguments().getInt(ARG_SECTION_NUMBER));
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnAddPropertyFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p/>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnAddPropertyFragmentInteractionListener {
        // TODO: Update argument type and name
        public void onFragmentInteraction(Uri uri);
    }

    public void startCamera() {
        Fragment cameraFragment = CameraFragment.newInstance();

        FragmentTransaction transaction = getActivity().getSupportFragmentManager()
                .beginTransaction();
        transaction.replace(R.id.container, cameraFragment);
        transaction.addToBackStack("AddPropertyFragment");
        transaction.commit();
    }

    /**
     * Represents an asynchronous login/registration task used to authenticate
     * the user.
     */
    public class AddPropertyTask extends AsyncTask<Void, Void, Boolean> {

        private final Context mContext;
        private final String title;
        private final String description;
        private final double price;
        private final String date;
        private final String pictureUrl;


        AddPropertyTask(Context context, String title, String description, double price, String date, String pictureUrl) {
            this.mContext = context;
            this.title = title;
            this.description = description;
            this.price = price;
            this.date = date;
            this.pictureUrl = pictureUrl;
        }

        @Override
        protected Boolean doInBackground(Void... params) {

            try {
                // Simulate network access.
                //Thread.sleep(2000);
                HttpClient httpClient = new DefaultHttpClient();
                HttpPost httpPost = new HttpPost(Constants.API_URL + Constants.VHS_OFFER);

                String json = "";

                // Build jsonObject
                JSONObject jsonObject = new JSONObject();
                jsonObject.accumulate("shortName", title);
                jsonObject.accumulate("description", description);
                jsonObject.accumulate("price", price);
                jsonObject.accumulate("mainImageUrl", pictureUrl);
                jsonObject.accumulate("latitude", 100);
                jsonObject.accumulate("longitude", 100);
                jsonObject.accumulate("publishDate", date);

                jsonObject.accumulate("offerCategory", new JSONObject().accumulate("idCategory", 1));

                // Convert JSONObject to JSON to String
                json = jsonObject.toString();

                Log.e("JSON: ", json);

                // Set json to StringEntity
                StringEntity se = new StringEntity(json);

                // Set httpPost Entity
                httpPost.setEntity(se);

                // Set some headers to inform server about the type of the content
                httpPost.setHeader("Accept", "application/json");
                httpPost.setHeader("Content-type", "application/json");

                // Make the POST request.
                HttpResponse response = httpClient.execute(httpPost);
                // Write response to log

                Log.e("RESPONSE: ", String.valueOf(response.getStatusLine().getStatusCode()));

                //No Response 204 or OK 200
                if (response.getStatusLine().getStatusCode() == 204 || response.getStatusLine().getStatusCode() == 200)
                {
                    //HttpEntity entity = response.getEntity();
                    //Log.d("Res of POST request", EntityUtils.toString(entity));
                    return true;
                }

            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            } catch (ClientProtocolException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (JSONException e) {
                e.printStackTrace();
            }
            return false;
        }

        @Override
        protected void onPostExecute(final Boolean success) {
            mPropertyTask = null;
            //showProgress(false);

            if (success) {
                Log.e("FUNCIONO", "Se agrego la promo");


            } else {
                Log.e("NO FUNCIONO", "No se agrego la promo");
            }
        }

        @Override
        protected void onCancelled() {
            mPropertyTask = null;
            //showProgress(false);
        }
    }
}