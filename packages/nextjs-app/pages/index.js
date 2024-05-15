import TabLayout from "#components/TabLayout";
import AuthProvider from '../pages/auth_provider';

const Page = () => {
  return (
    <div className="flex flex-col items-center justify-center py-2">
      Home 11
    </div>
  );
}

Page.Layout = ({ page }) => {
  return (
    <TabLayout>
      <AuthProvider>
        {page}
      </AuthProvider>
    </TabLayout>
  );
};

export default Page;
