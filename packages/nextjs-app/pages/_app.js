import "../styles/globals.css";
import React, { useEffect } from 'react';
import { Capacitor, Plugins } from '@capacitor/core';
import { NativeTabs } from "@lockvoid/capacitor-native-tabs";

//const { NativeTabs } = Plugins;

//console.log(Plugins)

const useTabSelection = () => {
  useEffect(() => {
    const onTabSelected = (event) => {
      const detail = JSON.parse(event.detail);
      console.log('Tab selected:', detail.tabIndex);
      // Here you could use something like React Router to navigate
      // Or update state to show/hide different components
    };

    window.addEventListener('onTabSelected', onTabSelected);

    return () => {
      window.removeEventListener('onTabSelected', onTabSelected);
    };
  }, []);
};

const App = ({ Component, pageProps }) => {
  const Layout = Component.Layout || (({ page }) => page);

  // useTabSelection();

  console.log("HELLO")

  useEffect(() => {
    // showRootScreen();
    
    // return;
    // NativeTabs.createTabs().catch(error => console.error('Error creating tabs:', error));


    // if (Capacitor.isPluginAvailable('NativeTabs')) {
    //   NativeTabs.createTabs().catch(error => console.error('Error creating tabs:', error));
    // } else {
    //   console.error('NativeTabs is not available');
    // }
  }, []);

  return (
    <Layout page={<Component {...pageProps} />} pageProps={pageProps} />
  );
};

export default App;
