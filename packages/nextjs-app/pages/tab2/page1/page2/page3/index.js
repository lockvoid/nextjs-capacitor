import TabLayout from "#components/TabLayout";
import ActiveLink from "#components/ActiveLink";

const Page1 = () => {
  return (
    <div className="flex flex-col items-center justify-center py-2">
      <div className="flex flex-row">
        <div className="text-base text-purple-500 font-medium ">
          Tab 2
        </div>
        
        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab2/page1">
          Page 1
        </ActiveLink>
        
        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab2/page1/page2">
          Page 2
        </ActiveLink>

        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab2/page1/page2/page3">
          Page 3
        </ActiveLink>

        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab2">
          Go to Root
        </ActiveLink>
      </div>
    </div>  
  );
}

Page1.Layout = ({ page }) => {
  return (
    <TabLayout>
      {page}
    </TabLayout>
  );
};

export default Page1;
