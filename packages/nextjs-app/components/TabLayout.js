import Link from '#components/Link';
import ActiveLink from './ActiveLink';

const TabLayout = ({ children }) => { 
  const handleTab1 = (event) => {
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

      window.Capacitor.Plugins.NativeTabs.presentViewController({ tabs });
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

      window.Capacitor.Plugins.NativeTabs.pushViewController({ tabs });
    }
  }

  const handleTab3 = (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

      window.Capacitor.Plugins.NativeTabs.pushViewController({ url: 'http://0.0.0.0:3000/tab2' });
    }
  }

  const handleTab4 = (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();

      window.Capacitor.Plugins.NativeTabs.pushViewController({ nativeUrl: 'redCustomVc' });
    }
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2 space-y-12"> 
      <div className="flex flex-col">
        {children}
      </div>

      <div className="flex flex-row space-x-6">
        <ActiveLink href="/tab1" className="bg-gray-300 rounded-lg p-2" activeClassName="bg-purple-600 text-white" onClick={handleTab1}>
          Tab 1
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white" onClick={handleTab2}>
          Tab 2
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white" onClick={handleTab3}>
          Tab 3
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white" onClick={handleTab4}>
          Tab 4
        </ActiveLink>
      </div>
    </div>
  );
}

export default TabLayout;