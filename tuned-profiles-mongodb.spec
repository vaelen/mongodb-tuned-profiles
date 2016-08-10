%define name    tuned-profiles-mongodb
%define version 1.0

Name:           %{name}
Version:        %{version}
Release:        1%{?dist}
Summary:        Additional tuned profile(s) targeted to MongoDB servers.

License:        GPLv3
URL:            https://github.com/vaelen/tuned-profiles-mongodb
Source:         %{name}-%{version}.tar.gz

BuildArch:      noarch 
BuildRoot:      %{_builddir}/%{name}-%{version}
Requires:       tuned
Vendor:         Andrew Young <andrew@vaelen.org>

%description
Additional tuned profile(s) which tune a system for use as a MongoDB server.

%prep
%setup -n %{name}-%{version}

%build
exit 0

%install
mkdir -p "${RPM_BUILD_ROOT}"/%{_prefix}
cp -r * "${RPM_BUILD_ROOT}"/%{_prefix}

%clean
rm -rf "${RPM_BUILD_ROOT}"/*

%files
%defattr(-,root,root,-)
%{_prefix}/lib/tuned/mongodb
%{_mandir}/man7/tuned-profiles-mongodb.7.gz

%doc

%changelog
