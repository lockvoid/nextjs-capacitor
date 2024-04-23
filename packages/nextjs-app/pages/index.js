import TabLayout from "#components/TabLayout";

const Page = () => {
  return (
    <div className="flex flex-col items-center justify-center py-2">
      Home 
    </div>
  );
}

Page.Layout = ({ page }) => {
  return (
    <TabLayout>
      {page}
    </TabLayout>
  );
};

export default Page;
