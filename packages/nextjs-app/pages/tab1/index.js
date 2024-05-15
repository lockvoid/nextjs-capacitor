import TabLayout from "#components/TabLayout";
import ActiveLink from "#components/ActiveLink";

const Page1 = () => {
  return (
    <div className="flex flex-col items-center justify-center py-2">
      <div className="flex flex-row">
        <div className="text-base text-gray-500 font-medium ">
          Tab 1
        </div>
        
        <span className="mx-2">{'>'}</span>

        <ActiveLink href="/tab1/page1">
          Page 1
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
