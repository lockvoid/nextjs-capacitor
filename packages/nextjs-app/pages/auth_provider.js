import React, { useEffect } from 'react';
import { Capacitor, Plugins } from '@capacitor/core';
import { NativeTabs } from "@lockvoid/capacitor-native-tabs";
import { useRouter } from 'next/router';

const AuthProvider = ({ children }) => {
  const router = useRouter(); 

  useEffect(() => {
    if (window.Capacitor.isNativePlatform()) {
      const handleBack = () => {
        console.log('back bla bla 123')
        router.back();
      }

      window.Capacitor.Plugins.NativeTabs.addListener('NAVIGATE_BACK', handleBack);

      return () => {
        window.Capacitor.Plugins.NativeTabs.removeListener('NAVIGATE_BACK', handleBack);
      }
    }
  }, []);

  const showRootScreen = async () => {
    const tabs = [
      {
        url: 'http://0.0.0.0:3000/tab2',
        title: 'tab 1',
      },
      {
        url: 'http://0.0.0.0:3000/tab2',
        title: 'tab 2',
      },
      {
        url: 'http://0.0.0.0:3000/tab2',
        title: 'tab 3',
      }
    ]

    const screenId = await window.Capacitor.Plugins.NativeTabs.createTabBar({ tabs });
    // const screenId = await window.Capacitor.Plugins.NativeTabs.createScreen({ url: 'fsdfsaf' });
    // window.Capacitor.Plugins.NativeTabs.pushViewController(screenId)
    window.Capacitor.Plugins.NativeTabs.presentViewController(screenId)
  }

  useEffect(() => {
    // showRootScreen();

    console.log('AuthProvider mount')
    return () => {
      console.log('AuthProvider will unmoumt');
      // Здесь нужно добавить ваш код для очистки.
    };
  }, []);

  return children;
};

export default AuthProvider;
