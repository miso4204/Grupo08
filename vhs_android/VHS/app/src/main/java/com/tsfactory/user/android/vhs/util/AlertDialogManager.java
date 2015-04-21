package com.tsfactory.user.android.vhs.util;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

import com.tsfactory.user.android.vhs.R;

public class AlertDialogManager {

    /**
     * Function to display simple Alert Dialog
     * @param context - application context
     * @param title - alert dialog title
     * @param message - alert message
     * @param status - success/failure (used to set icon)
     *               - pass null if you don't want icon
     * */
    public void showNeutralAlertDialog(Context context, String title, String message,
                                Boolean status) {

        AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
                context);

        alertDialogBuilder
                .setTitle(title)
                .setCancelable(false)
                .setMessage(message)
                .setNeutralButton("Ok", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {

                    }
                });
        /*
        if(status != null)
            // Setting alert dialog icon
            alertDialogBuilder.setIcon((status) ? R.drawable.success : R.drawable.fail);
        */

        // create alert dialog
        AlertDialog alertDialog = alertDialogBuilder.create();

        // show it
        alertDialog.show();

    }
}
