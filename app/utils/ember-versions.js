import { compare } from 'compare-versions';

export const VERSIONS = Object.freeze([
  '0.13',
  '1.0.0-pre',
  '1.0.0-pre.2',
  '1.0.0-rc.1',
  '1.0.0-rc.2',
  '1.0.0-rc.3',
  '1.0.0-rc.4',
  '1.0.0-rc.5',
  '1.0.0-rc.6',
  '1.0.0-rc.7',
  '1.0.0-rc.8',
  '1.0',
  '1.0.0-beta.2',
  '1.0.0-beta.9',
  '1.0.0-beta.12',
  '1.0.0-beta.14',
  '1.0.0-beta.15',
  '1.0.0-beta.16',
  '1.0.0-beta.18',
  '1.0.0-beta.19',
  '1.1.2',
  '1.3',
  '1.4',
  '1.5',
  '1.6',
  '1.7',
  '1.8',
  '1.8.1',
  '1.9',
  '1.9.1',
  '1.10',
  '1.11',
  '1.12',
  '1.13',
  '2.0.0-beta.1',
  '2.0',
  '2.1',
  '2.2',
  '2.3',
  '2.4',
  '2.5',
  '2.6',
  '2.7',
  '2.8',
  '2.9',
  '2.10',
  '2.11',
  '2.12',
  '2.13',
  '2.14',
  '2.15',
  '2.16',
  '2.17',
  '2.18',
  '3.0',
  '3.1',
  '3.2',
  '3.3',
  '3.4',
  '3.5',
  '3.6',
  '3.7',
  '3.8',
  '3.9',
  '3.10',
  '3.11',
  '3.12',
  '3.13',
  '3.14',
  '3.15',
  '3.16',
  '3.17',
  '3.18',
  '3.19',
  '3.20',
  '3.21',
  '3.22',
  '3.23',
  '3.24',
  '3.25',
  '3.26',
  '3.27',
  '3.28',
  '4.0',
  '4.1',
  '4.2',
  '4.3',
  '4.4',
  '4.5',
  '4.6',
  '4.7',
  '4.8',
  '4.9',
  '4.10',
  '4.11',
  '4.12',
  '5.0',
  '5.1',
  '5.2',
  '5.3',
  '5.4',
  '5.5',
  '5.6',
  '5.7',
  '5.8',
  '5.9',
  '5.10',
  '5.11',
  '5.12',
  '6.0',
  '6.1',
  '6.2',
  '6.3',
  '6.4',
  '6.5',
  '6.6',
  '6.7',
  '6.8',
  '6.9',
  '6.10',
  '6.11',
  '6.12',
  '7.0',
]);

export const DEFAULT_FROM_VERSION = '3.15';
export const DEFAULT_TO_VERSION = VERSIONS[VERSIONS.length - 1];

// Group the versions by major so we can display option groups.
export const GROUPED_VERSIONS = VERSIONS.reduce((acc, version) => {
  const major = version.split('.')[0];
  let group = acc.find((g) => g.major === major);
  if (!group) {
    group = { major, versions: [] };
    acc.push(group);
  }
  group.versions.push(version);
  return acc;
}, []);

export const isLegalVersion = (version) => {
  return VERSIONS.includes(version);
};

/** Utility to check that from/to combination is allowed. */
export const areVersionsValid = (fromVersion, toVersion) => {
  if (!fromVersion || !toVersion) {
    return true;
  }

  return compare(fromVersion, toVersion, '<');
};
