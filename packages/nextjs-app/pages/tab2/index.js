import TabLayout from "#components/TabLayout";
import ActiveLink from "#components/ActiveLink";
import { useRouter } from 'next/router';

const Page1 = () => {
  // const handleTab1 = async (event) => {
  //   if (window.Capacitor.isNativePlatform()) {
  //     event.preventDefault();

  //     // const tabs = [
  //     //   {
  //     //     url: 'http://0.0.0.0:3000/tab2',
  //     //     title: 'tab 1',
  //     //   },
  //     //   {
  //     //     url: 'http://0.0.0.0:3000/tab2',
  //     //     title: 'tab 2',
  //     //   },
  //     //   {
  //     //     url: 'http://0.0.0.0:3000/tab2',
  //     //     title: 'tab 3',
  //     //   }
  //     // ]
      
  //     await window.Capacitor.Plugins.NativeNavigation.prepareViewController({ });
  //     router.push('/tab2');
  //     await window.Capacitor.Plugins.NativeNavigation.presentViewController({ url: 'http://0.0.0.0:3000/tab2' });
  //   }
  // }
  const router = useRouter(); 

  const handleBack = async (event) => {
    if (window.Capacitor.isNativePlatform()) {
      event.preventDefault();
      await window.Capacitor.Plugins.NativeNavigation.prepareViewController({ });
      router.back();
      await window.Capacitor.Plugins.NativeNavigation.dismissViewController({});
    }
  }

  return (
    <div className="flex flex-col items-center justify-center py-2">
      <div className="flex flex-row">
        <div className="text-base text-gray-500 font-medium ">
          Tab 2
        </div>
        
        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab2/page1">
          Page 1
        </ActiveLink>
      </div>

      <div className="flex flex-row space-x-6">
        <ActiveLink href="/tab1" className="bg-gray-300 rounded-lg p-2" activeClassName="bg-purple-600 text-white" onClick={handleBack}>
          Tab 1
        </ActiveLink>
      </div>
    </div>  
  );
}

Page1.Layout = ({ page }) => {
  return (
    <div className="flex flex-col">
      {page}
    </div>
  );
};

export default Page1;
