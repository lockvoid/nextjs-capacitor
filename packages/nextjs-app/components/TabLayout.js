import Link from '#components/Link';
import ActiveLink from './ActiveLink';
import { useRouter } from 'next/router';

const TabLayout = ({ children }) => { 

  const router = useRouter(); 
  const handleTab1 = async (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

      // const tabs = [
      //   {
      //     url: 'http://0.0.0.0:3000/tab2',
      //     title: 'tab 1',
      //   },
      //   {
      //     url: 'http://0.0.0.0:3000/tab2',
      //     title: 'tab 2',
      //   },
      //   {
      //     url: 'http://0.0.0.0:3000/tab2',
      //     title: 'tab 3',
      //   }
      // ]
      
      await window.Capacitor.Plugins.NativeNavigation.snapshotViewController({ });
      await router.push('/tab2');
      await window.Capacitor.Plugins.NativeNavigation.presentViewController({ });
    }
  }

  const handleTab2 = (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

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

      window.Capacitor.Plugins.NativeNavigation.pushViewController({ tabs });
    }
  }

  const handleTab3 = async (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

      await window.Capacitor.Plugins.NativeNavigation.snapshotViewController({ });
      await router.push('/tab2');
      await window.Capacitor.Plugins.NativeNavigation.pushViewController({ });
    }
  }

  const handleTab4 = (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

      window.Capacitor.Plugins.NativeNavigation.pushViewController({ url: 'native://redCustomVc' });
    }
  }

  const handleTab5 = async (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

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

      await window.Capacitor.Plugins.NativeNavigation.setMainViewController({ tabs });
    }
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2 space-y-12"> 
      <div className="flex flex-col">
        {children}
      </div>

      <div className="flex flex-col space-y-2">
        <ActiveLink href="/tab1" className="bg-gray-300 rounded-lg p-2" activeClassName="bg-purple-600 text-white" onClick={handleTab1}>
          Present Tab2
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white" onClick={handleTab2}>
          Push Tabbar
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white" onClick={handleTab3}>
          Push tab2
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white" onClick={handleTab4}>
          Push native
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white" onClick={handleTab5}>
          Set main TabBar
        </ActiveLink>
      </div>
    </div>
  );
}

export default TabLayout;