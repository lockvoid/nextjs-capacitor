import Link from '#components/Link';
import ActiveLink from './ActiveLink';

const TabLayout = ({ children }) => { 
  return (
    <div className="flex flex-col items-center justify-center min-h-screen py-2 space-y-12"> 
      <div className="flex flex-col">
        {children}
      </div>

      <div className="flex flex-row space-x-6">
        <ActiveLink href="/tab1" className="bg-gray-300 rounded-lg p-2" activeClassName="bg-purple-600 text-white">
          Tab 1
        </ActiveLink>

        <ActiveLink href="/tab2" className="bg-gray-300 rounded-lg p-2"  activeClassName="bg-purple-600 text-white">
          Tab 2
        </ActiveLink>
      </div>
    </div>
  );
}

export default TabLayout;