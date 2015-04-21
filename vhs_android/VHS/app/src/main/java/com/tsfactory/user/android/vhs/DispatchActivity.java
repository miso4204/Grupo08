package com.tsfactory.user.android.vhs;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.tsfactory.user.android.vhs.util.SessionManager;

/**
 * Activity which starts an intent for either the logged in (MainActivity) or logged out
 * (SignUpOrLoginActivity) activity.
 */

public class DispatchActivity extends Activity {

    // Session Manager Class
    SessionManager session;

    public DispatchActivity() {
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // Check if there is current user info
        session = new SessionManager(getApplicationContext());

        if (session.isLoggedIn()) {
            // Start an intent for the logged in activity
            startActivity(new Intent(this, MainActivity.class));
        } else {
            // Start and intent for the logged out activity
            startActivity(new Intent(this, WelcomeActivity.class));
        }
    }

}
