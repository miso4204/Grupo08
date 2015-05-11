package com.tsfactory.user.android.vhs.fragments;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.app.Activity;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import com.tsfactory.user.android.vhs.MainActivity;
import com.tsfactory.user.android.vhs.R;
import com.tsfactory.user.android.vhs.util.Constants;
import com.tsfactory.user.android.vhs.util.SessionManager;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;

/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link ProfileFragment.OnProfileFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link ProfileFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ProfileFragment extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private OnProfileFragmentInteractionListener mListener;

    /**
     * The fragment argument representing the section number for this
     * fragment.
     */
    private static final String ARG_SECTION_NUMBER = "section_number";

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.

     * @return A new instance of fragment ProfileFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static ProfileFragment newInstance(int sectionNumber) {
        ProfileFragment fragment = new ProfileFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.setArguments(args);
        return fragment;
    }

    /**
     * Keep track of the UpdateProfile task to ensure we can cancel it if requested.
     */
    private UpdateUserTask mSaveTask = null;

    // Session Manager Class
    SessionManager session;
    // User Data
    HashMap<String, String> user;

    // UI references.
    private EditText mEmailView;
    private EditText mPasswordView;
    private EditText mFullNameView;
    private View mProgressView;
    private View mProfileFormView;

    public ProfileFragment() {
        // Required empty public constructor
    }

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
        View view = inflater.inflate(R.layout.fragment_profile, container, false);

        session = new SessionManager(getActivity().getApplicationContext());
        user = session.getUserDetails();

        // Set up the profile form.
        mEmailView = (EditText) view.findViewById(R.id.profile_email);
        mEmailView.setText(user.get(SessionManager.KEY_EMAIL));

        mPasswordView = (EditText) view.findViewById(R.id.profile_password);
        mPasswordView.setText(user.get(SessionManager.KEY_PASSWORD));

        mFullNameView = (EditText) view.findViewById(R.id.profile_full_name);
        mFullNameView.setText(user.get(SessionManager.KEY_NAME));

        Button mSaveProfileButton = (Button) view.findViewById(R.id.profile_save_button);
        mSaveProfileButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                attemptSaveProfile();
            }
        });

        mProfileFormView = view.findViewById(R.id.profile_form);
        mProgressView = view.findViewById(R.id.profile_progress);
        
        return view;
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onProfileFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Activity activity) {
        super.onAttach(activity);
        try {
            mListener = (OnProfileFragmentInteractionListener) activity;

            ((MainActivity) activity).onSectionAttached(
                    getArguments().getInt(ARG_SECTION_NUMBER));
        } catch (ClassCastException e) {
            throw new ClassCastException(activity.toString()
                    + " must implement OnProfileFragmentInteractionListener");
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
    public interface OnProfileFragmentInteractionListener {
        // TODO: Update argument type and name
        public void onProfileFragmentInteraction(Uri uri);
    }

    /**
     * Attempts to register the account specified by the sign up form.
     * If there are form errors (invalid email, missing fields, etc.), the
     * errors are presented and no actual register attempt is made.
     */
    public void attemptSaveProfile() {
        if (mSaveTask != null) {
            return;
        }

        // Reset errors.
        mEmailView.setError(null);
        mPasswordView.setError(null);
        mFullNameView.setError(null);

        // Store values at the time of the sign up attempt.
        String email = mEmailView.getText().toString();
        String password = mPasswordView.getText().toString();
        String fullName = mFullNameView.getText().toString();

        boolean cancel = false;
        View focusView = null;

        // Check for a valid email address.
        if (TextUtils.isEmpty(email)) {
            mEmailView.setError(getString(R.string.error_field_required));
            focusView = mEmailView;
            cancel = true;
        }

        // Check for a valid password.
        if (TextUtils.isEmpty(password)) {
            mPasswordView.setError(getString(R.string.error_field_required));
            focusView = mPasswordView;
            cancel = true;
        }

        // Check for a valid fullName.
        if (TextUtils.isEmpty(fullName)) {
            mFullNameView.setError(getString(R.string.error_field_required));
            focusView = mFullNameView;
            cancel = true;
        }

        if (cancel) {
            // There was an error; don't attempt sign up and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user sign up attempt.
            showProgress(true);
            mSaveTask = new UpdateUserTask(email, password, fullName);
            mSaveTask.execute((Void) null);
        }
    }

    /**
     * Shows the progress UI and hides the login form.
     */
    @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
    public void showProgress(final boolean show) {
        // On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
        // for very easy animations. If available, use these APIs to fade-in
        // the progress spinner.
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
            int shortAnimTime = getResources().getInteger(android.R.integer.config_shortAnimTime);

            mProfileFormView.setVisibility(show ? View.GONE : View.VISIBLE);
            mProfileFormView.animate().setDuration(shortAnimTime).alpha(
                    show ? 0 : 1).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    mProfileFormView.setVisibility(show ? View.GONE : View.VISIBLE);
                }
            });

            mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
            mProgressView.animate().setDuration(shortAnimTime).alpha(
                    show ? 1 : 0).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
                }
            });
        } else {
            // The ViewPropertyAnimator APIs are not available, so simply show
            // and hide the relevant UI components.
            mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
            mProfileFormView.setVisibility(show ? View.GONE : View.VISIBLE);
        }
    }

    /**
     * Represents an asynchronous login/registration task used to authenticate
     * the user.
     */
    public class UpdateUserTask extends AsyncTask<Void, Void, Boolean> {

        private final String mEmail;
        private final String mPassword;
        private final String mFullName;

        UpdateUserTask(String email, String password, String fullName) {
            mEmail = email;
            mPassword = password;
            mFullName = fullName;
        }

        @Override
        protected Boolean doInBackground(Void... params) {

            try {
                // Simulate network access.
                //Thread.sleep(2000);
                HttpClient httpClient = new DefaultHttpClient();
                //HttpPost httpPost = new HttpPost(Constants.API_URL + Constants.VHS_USER);
                HttpPut httpPut = new HttpPut(Constants.API_URL + Constants.VHS_USER + user.get(SessionManager.KEY_UID));

                Log.e("URL: ", Constants.API_URL + Constants.VHS_USER + user.get(SessionManager.KEY_UID));

                String json = "";

                // Build jsonObject
                JSONObject jsonObject = new JSONObject();
                jsonObject.accumulate("userId", user.get(SessionManager.KEY_UID));
                jsonObject.accumulate("mail", mEmail);
                jsonObject.accumulate("password", mPassword);
                jsonObject.accumulate("fullName", mFullName);

                // Convert JSONObject to JSON to String
                json = jsonObject.toString();

                Log.e("JSON: ", json);

                // Set json to StringEntity
                StringEntity se = new StringEntity(json);

                // Set httpPost Entity
                httpPut.setEntity(se);

                // Set some headers to inform server about the type of the content
                httpPut.setHeader("Content-type", "application/json");

                // Make the POST request.
                HttpResponse response = httpClient.execute(httpPut);
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
            mSaveTask = null;
            showProgress(false);

            if (success) {
                Log.e("RESPONSE: ", "EXITO");

            } else {
                mEmailView.setError(getString(R.string.profile_update_error));
                mEmailView.requestFocus();
            }
        }

        @Override
        protected void onCancelled() {
            mSaveTask = null;
            showProgress(false);
        }
    }

}
