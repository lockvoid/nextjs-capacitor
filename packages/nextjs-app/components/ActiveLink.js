import clsx from 'clsx';
import Link from '#components/Link';
import { usePathname } from 'next/navigation';
import { twMerge } from 'tailwind-merge'

const ActiveLink = ({ text, children, href, className = 'underline', activeClassName = 'no-underline' }) => {
  const pathname = usePathname();

  const active = pathname?.startsWith(href);

  return (
    <Link className={twMerge('text-base text-gray-500 font-medium underscore hover:text-gray-300', className, active && activeClassName)} href={href}>
      {text || children}
    </Link>
  );
}

export default ActiveLink;
