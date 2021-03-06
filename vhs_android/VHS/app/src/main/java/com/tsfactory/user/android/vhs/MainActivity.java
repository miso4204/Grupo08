package com.tsfactory.user.android.vhs;

import android.app.Activity;
import android.net.Uri;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.support.v4.widget.DrawerLayout;
import android.widget.Toast;

import com.tsfactory.user.android.vhs.fragments.AddPropertyFragment;
import com.tsfactory.user.android.vhs.fragments.CameraFragment;
import com.tsfactory.user.android.vhs.fragments.ItemFragment;
import com.tsfactory.user.android.vhs.fragments.ProfileFragment;
import com.tsfactory.user.android.vhs.util.AlertDialogManager;
import com.tsfactory.user.android.vhs.util.SessionManager;

//import java.util.HashMap;


public class MainActivity extends ActionBarActivity
        implements NavigationDrawerFragment.NavigationDrawerCallbacks,
                   ItemFragment.OnItemFragmentInteractionListener,
                   AddPropertyFragment.OnAddPropertyFragmentInteractionListener,
                   CameraFragment.OnCameraFragmentInteractionListener,
                   ProfileFragment.OnProfileFragmentInteractionListener {

    /**
     * Fragment managing the behaviors, interactions and presentation of the navigation drawer.
     */
    private NavigationDrawerFragment mNavigationDrawerFragment;

    /**
     * Used to store the last screen title. For use in {@link #restoreActionBar()}.
     */
    private CharSequence mTitle;

    // Alert Dialog Manager
    AlertDialogManager alert = new AlertDialogManager();

    // Session Manager Class
    SessionManager session;

    /**
     * Class to manage the items on the Navigation Drawer.
     */
    public class MenuItems {
        public final static int MY_PROPERTIES = 0;
        public final static int ADD_PROPERTY  = 1;
        public final static int MY_PROFILE    = 2;
        public final static int LOG_OUT       = 3;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Session class instance
        session = new SessionManager(getApplicationContext());
        Toast.makeText(getApplicationContext(), "User Login Status: " + session.isLoggedIn(), Toast.LENGTH_LONG).show();

        //Call this function whenever you want to check user login
        session.checkLogin();

        /**
         * Get user data from session
         * HashMap<String, String> user = session.getUserDetails();
         * User name:
         * String name = user.get(SessionManager.KEY_NAME);
         * User email:
         * String email = user.get(SessionManager.KEY_EMAIL);
         */

        mNavigationDrawerFragment = (NavigationDrawerFragment)
                getSupportFragmentManager().findFragmentById(R.id.navigation_drawer);
        mTitle = getTitle();

        // Set up the drawer.
        mNavigationDrawerFragment.setUp(
                R.id.navigation_drawer,
                (DrawerLayout) findViewById(R.id.drawer_layout));
    }

    @Override
    public void onNavigationDrawerItemSelected(int position) {
        // update the main content by replacing fragments
        /*
        FragmentManager fragmentManager = getSupportFragmentManager();
        fragmentManager.beginTransaction()
        .replace(R.id.container, PlaceholderFragment.newInstance(position + 1))
        .commit();
        */

        FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
        switch (position) {
            case MenuItems.MY_PROPERTIES:
                //fragmentTransaction.replace(R.id.container, PlaceholderFragment.newInstance(position + 1));
                fragmentTransaction.replace(R.id.container, ItemFragment.newInstance(position + 1));
                break;

            case MenuItems.ADD_PROPERTY:
                fragmentTransaction.replace(R.id.container, AddPropertyFragment.newInstance(position + 1));
                break;

            case MenuItems.MY_PROFILE:
                fragmentTransaction.replace(R.id.container, ProfileFragment.newInstance(position + 1));
                break;

            case MenuItems.LOG_OUT:
                session.logoutUser();
                break;
        }
        fragmentTransaction.commit();
    }

    public void onSectionAttached(int number) {
        switch (number) {
            case 1:
                mTitle = getString(R.string.title_section1);
                break;
            case 2:
                mTitle = getString(R.string.title_section2);
                break;
            case 3:
                mTitle = getString(R.string.title_section3);
                break;
            case 4:
                mTitle = getString(R.string.title_section4);
                break;
        }
    }

    public void restoreActionBar() {
        ActionBar actionBar = getSupportActionBar();
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_STANDARD);
        actionBar.setDisplayShowTitleEnabled(true);
        actionBar.setTitle(mTitle);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        if (!mNavigationDrawerFragment.isDrawerOpen()) {
            // Only show items in the action bar relevant to this screen
            // if the drawer is not showing. Otherwise, let the drawer
            // decide what to show in the action bar.
            getMenuInflater().inflate(R.menu.main, menu);
            restoreActionBar();
            return true;
        }
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {
        /**
         * The fragment argument representing the section number for this
         * fragment.
         */
        private static final String ARG_SECTION_NUMBER = "section_number";

        /**
         * Returns a new instance of this fragment for the given section
         * number.
         */
        public static PlaceholderFragment newInstance(int sectionNumber) {
            PlaceholderFragment fragment = new PlaceholderFragment();
            Bundle args = new Bundle();
            args.putInt(ARG_SECTION_NUMBER, sectionNumber);
            fragment.setArguments(args);
            return fragment;
        }

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);
            return rootView;
        }

        @Override
        public void onAttach(Activity activity) {
            super.onAttach(activity);
            ((MainActivity) activity).onSectionAttached(
                    getArguments().getInt(ARG_SECTION_NUMBER));
        }
    }

    @Override
    public void onItemSelected(String id) {
        Log.e("Main" , "ID: " + id);
    }

    @Override
    public void onFragmentInteraction(Uri uri) {
        Log.e("Main" , "Uri: " + uri);
    }

    @Override
    public void onCameraFragmentInteraction(Uri uri) {
        Log.e("Main" , "Uri: " + uri);
    }

    @Override
    public void onProfileFragmentInteraction(Uri uri) {
        Log.e("Main" , "Uri: " + uri);
    }
}
