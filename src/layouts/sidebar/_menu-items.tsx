import routes from '@/config/routes';
import { HomeIcon } from '@/components/icons/home';
import { FarmIcon } from '@/components/icons/farm';
import { PoolIcon } from '@/components/icons/pool';
import { ProfileIcon } from '@/components/icons/profile';
import { DiskIcon } from '@/components/icons/disk';
import { ExchangeIcon } from '@/components/icons/exchange';
import { VoteIcon } from '@/components/icons/vote-icon';
import { PlusCircle } from '@/components/icons/plus-circle';
import { CompassIcon } from '@/components/icons/compass';

export const menuItems = [
  {
    name: 'Home',
    icon: <HomeIcon />,
    href: routes.home,
  },
  {
    name: 'Explore',
    icon: <CompassIcon />,
    href: routes.search,
  },
  {
    name: 'Drive',
    icon: <ExchangeIcon />,
    href: routes.sensor,
  },
  {
    name: 'Check-In',
    icon: <PlusCircle />,
    href: routes.checkin,
  },
  {
    name: 'Bridge',
    icon: <PoolIcon />,
    href: 'https://portal.astar.network/zkatana-testnet/bridge/ethereum',
    target: '_blank',
  },
];
