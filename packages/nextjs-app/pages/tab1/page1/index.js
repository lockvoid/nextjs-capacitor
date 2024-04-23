import TabLayout from "#components/TabLayout";
import ActiveLink from "#components/ActiveLink";

const Page1 = () => {
  return (
    <div className="flex flex-col items-center justify-center py-2">
      <div className="flex flex-row">
        <div className="text-base text-purple-500 font-medium ">
          Tab 1
        </div>
        
        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab1/page1">
          Page 1
        </ActiveLink>
        
        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab1/page1/page2">
          Page 2
        </ActiveLink>
      </div>
    </div>  
  );
}

Page1.Layout = ({ page }) => {
  return (
    <TabLayout>
    </TabLayout>
  );
};

export default Page1;
