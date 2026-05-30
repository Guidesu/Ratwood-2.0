import { Dispatch, SetStateAction, useState } from 'react';
import { Box, Button, Input, Section } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type LoadoutItem = {
  name: string;
  desc: string;
  triumph_cost: number | null;
  item_type: string;
  nobility_check: boolean;
  donoritem: boolean;
  ref: string;
  icon: string;
};

type Data = {
  loadout_items: LoadoutItem[];
};

// Order matters
const TYPE_CATEGORIES: [string, string][] = [
  ['/obj/item/clothing/head', 'Hats & Hoods'],
  ['/obj/item/clothing/cloak', 'Cloaks & Tabards'],
  ['/obj/item/clothing/suit', 'Shirts & Tops'],
  ['/obj/item/clothing/under', 'Pants & Bottoms'],
  ['/obj/item/clothing/shoes', 'Shoes & Boots'],
  ['/obj/item/clothing/gloves', 'Gloves'],
  ['/obj/item/clothing/mask', 'Masks & Eyewear'],
  ['/obj/item/clothing/neck', 'Necklaces & Amulets'],
  ['/obj/item/clothing/wrists', 'Wrist Accessories'],
  ['/obj/item/clothing/ring', 'Rings'],
  ['/obj/item/storage/belt', 'Belts'],
  ['/obj/item/storage', 'Storage'],
  ['/obj/item/rogueweapon', 'Weapons & Tools'],
  ['/obj/item/cooking', 'Cookware'],
  ['/obj/item/reagent_containers/glass/bucket', 'Cookware'],
  ['/obj/item/reagent_containers/glass/bowl', 'Cookware'],
  ['/obj/item/reagent_containers/glass/cup', 'Drinkware'],
  ['/obj/item/reagent_containers', 'Containers'],
  ['/obj/item/kitchen', 'Kitchen Tools'],
  ['/obj/item/flowercrown', 'Flower Crowns'],
  ['/obj/item/toy', 'Toys & Games'],
  ['/obj/item/paper', 'Books & Paper'],
  ['/obj/item/natural', 'Natural Items'],
  ['/obj/item/chastity', 'Accessories'],
];

const getCategory = (item_type: string): string => {
  for (const [prefix, label] of TYPE_CATEGORIES) {
    if (item_type.startsWith(prefix)) return label;
  }
  return 'Miscellaneous';
};

export const LoadoutMenu = (props) => {
  return (
    <Window width={1400} height={900}>
      <Window.Content>
        <ItemDisplay />
      </Window.Content>
    </Window>
  );
};

export const SearchBar = (props: {
  search: string;
  setSearch: Dispatch<SetStateAction<string>>;
}) => {
  const { search, setSearch } = props;
  return <Input value={search} onChange={setSearch} fluid />;
};

export const ItemDisplay = (props) => {
  const [search, setSearch] = useState('');

  const { act, data } = useBackend<Data>();
  const { loadout_items } = data;

  const availableItems = loadout_items
    .filter((item) => item.nobility_check && item.donoritem)
    .filter((item) =>
      search ? item.name.toLowerCase().includes(search.toLowerCase()) : true,
    );

  // Group by item type category
  const grouped = new Map<string, LoadoutItem[]>();
  for (const item of availableItems) {
    const cat = getCategory(item.item_type);
    if (!grouped.has(cat)) grouped.set(cat, []);
    grouped.get(cat)!.push(item);
  }

  // Preserve the order categories appear in TYPE_CATEGORIES, unknown at end
  const knownOrder = TYPE_CATEGORIES.map(([, label]) => label).filter(
    (v, i, a) => a.indexOf(v) === i,
  );
  const allCats = [...grouped.keys()];
  const sortedCategories = [
    ...knownOrder.filter((c) => allCats.includes(c)),
    ...allCats.filter((c) => !knownOrder.includes(c)).sort(),
  ];

  for (const cat of sortedCategories) {
    grouped.get(cat)!.sort((a, b) => a.name.localeCompare(b.name));
  }

  const CELL_SIZE = 96;

  return (
    <Section
      title="Items"
      fill
      scrollable
      buttons={<SearchBar search={search} setSearch={setSearch} />}
    >
      {sortedCategories.map((cat) => (
        <Box key={cat} mb={1}>
          <Box
            bold
            fontSize="0.8rem"
            color="label"
            style={{ textTransform: 'uppercase', marginBottom: '0.25rem' }}
          >
            {cat}
          </Box>
          <Box
            style={{
              display: 'grid',
              gridTemplateColumns: `repeat(auto-fill, ${CELL_SIZE}px)`,
              gap: '0.25rem',
            }}
          >
            {grouped.get(cat)!.map((item) => (
              <Button
                key={item.ref}
                onClick={() => act('choose_item', { ref: item.ref })}
                tooltip={item.desc}
                style={{
                  width: `${CELL_SIZE}px`,
                  minHeight: `${CELL_SIZE}px`,
                  padding: '0.3rem',
                  textAlign: 'center',
                  whiteSpace: 'normal',
                  height: 'auto',
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  gap: '2px',
                }}
              >
                <Box className={item.icon} style={{ fontSize: '24px', display: 'block' }} />
                <Box
                  bold
                  fontSize="0.65rem"
                  style={{
                    lineHeight: '1.2',
                    display: 'block',
                    width: '100%',
                    wordBreak: 'break-word',
                  }}
                >
                  {item.name}
                </Box>
                <Box
                  fontSize="0.6rem"
                  color="label"
                  style={{
                    lineHeight: '1.2',
                    display: 'block',
                    width: '100%',
                  }}
                >
                  {item.triumph_cost ? `${item.triumph_cost} pts` : 'Free'}
                </Box>
              </Button>
            ))}
          </Box>
        </Box>
      ))}
    </Section>
  );
};

