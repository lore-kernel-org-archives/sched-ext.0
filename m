Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277818B0F
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784218; cv=fail; b=gZ7lIY7flRym1y6VYe/bPiGXKiGLppVloXnpn6DJ5g26ThE7b3cwTUDgrha2LCjMR3HdDHW0FZmhNHwmjrQQYCcmJ4Id7kznYkqCEoiZCfJlLMWVxqgWR9Q1F2nDHpl7RbpBv7dfNgEfo0o2OUZJR+G6U8EX9w1ecXj2JmcuLEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784218; c=relaxed/simple;
	bh=hs0OxkMTagQfFTlXTbWRHxRRwMww6d0DZH25ocQoR6M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bkgWJbkrT8pPQPILGndgbztoCs9i7Ce+f8PGtX6au7mQgD0MDaAKdFUf7e9P/CqvGTDQqWOHB34fGBQwZm7eCXmSv1TzmSTdVhrmwjvkaP/IEq+E0Rk562mXm3kqXSRtvydyRkJm+m4CX4uriDg6Rw+vrTJnV+TgBQVQs2yRO74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NsKF4/As; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NsKF4/As"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yrx/KzDKP8sHWwwIMFZ3urgcaryfBYcgkjK9iZhotgAZJixs472tPMl4faDEvG/jKN3KZNh7/HxeKcNKbhuUhVbVlLV3o+g4v55jb3QGOZ/TH09d4eIUw+zMMYx5Pes/ZCd4GhQKaIFdoRv9fFcPW1MLHCLi3oMcl5IwEdWv9Y1iEfVPncbkjx3cKhC1E8cBDs17Ehzu8Up9N6vdtjwDPToQwQMiGxLcF9KsqhFY88rtjwHBkqZbf7x9drpw7d4mvyiXIFdkFO3LaSVcLcw2kjlVUZDGpQr8Tbb9gIV5t6dDx/AvkS4LWe4WLorcLufYaCFoGcgPMd52SbcryfQRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMdATOJIH7/ivfzm+VvheUC2QKdc/mIBW85mlJuhQb4=;
 b=W/74uzrVFjACupNUSSl32ZjHkLWNn2QmqOCtXIzRWO9qCaED9ZdMJqNhiEUy3H8XlwtlXVz7kwUqQfnRDidqDjC9yhwLqXTq2hRYaLI5IdG2aKd9Y/RNbL6Gu7zd9cFJe5X7JAGOr1eE5+uZLIVilq0hu9f99/WhGKcpWAaLG1miCADvvTXK0uY2YeAUGk/WWzaTghTVkkvURrM5FUPrZfrU/qTwTc4b3PSBZGQ9X4ReScg34TzNJpvCVN/Kd64hjEgrzfWRYIzILr1YTofEJCnjunul69bYlW9PZ5sfwuhLmuvMxxcBGEc1JLgqiCEJJWgcS34iEZhkARPKRHBaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMdATOJIH7/ivfzm+VvheUC2QKdc/mIBW85mlJuhQb4=;
 b=NsKF4/As9poZcc+sBlagSa2l9RumiHv8dXYeJlItx7CF/LiM1rLOLwUVAEKEHckQx8ZCr5JoCbxS0qZULR34w1MmEpCj+TNATDm71iq0FIBX0gem4kkdBV2VPhmdPWSbmqkKEgl5t1PzL+2QGL29TqOk9+DiYr6v8hmrd+2W+ROHwbj2WBL4psRM4h+MxCcMcvU6HuOWhrQz/f2l6sLmb85BS7093e++LLkFbdvzoDdCkg2SkHZw5NOjSgM8CFZtc54NroT4XrqqTBiVt93Qa98KIwrtRNrh6xBKizT6nilF0mwVdrmSNuXhodtbbvMFXCpaKiWOKjsuecDVLTTKhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4824.namprd12.prod.outlook.com (2603:10b6:610:b::22)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 08:30:09 +0000
Received: from CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9]) by CH2PR12MB4824.namprd12.prod.outlook.com
 ([fe80::34d6:fda7:9290:35a9%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 08:30:09 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Phil Auld <pauld@redhat.com>,
	Koba Ko <kobak@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v2 sched_ext/for-7.2] sched_ext: Auto-manage ext/fair dl_server bandwidth
Date: Tue, 26 May 2026 10:27:54 +0200
Message-ID: <20260526082954.550958-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::16) To CH2PR12MB4824.namprd12.prod.outlook.com
 (2603:10b6:610:b::22)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4824:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 29af6abc-65c6-404b-2298-08debb00ff18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|11063799006|6133799003|5023799004|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M97f+QW0fUtxI54+e3kdn6h4T7EArplmjmsVzBw+l531MMl9aWNs4U3FxVeCjoDqfYbH508fBpWWVG7vJuQ7CTQKMhIqf8BSm2eXeqqaKK/blbjludsx5URLWNA4+o/+sXsK7Fml5j4p6IvKz/AyEYJJgflV21u0iu1c+G4gWgYBjunPrT/Bf8+Bd4gjtuVGlO+35weNjWAuih7Auq+AWruGOVIhnkJXWGRjdDZTTv8qRL6YeuBxQQixoo8CbE48TTCF4CWb6+iasvbnI41bn6d/rzFLcALa6YW/6jWxIgZ7BpsWF22B80kMAFx8tuHii2Gqaoebo6Qx4B2lp0y0+s8gge9nGeUefKEkp+dm/lhpS/ZwHE4txMd5P87ont3C0l9O4MKmRzpHenVEGbsWBXJapXmjgLKKJ3nLEi0zGrpIrzaQQyw+Xjn9xcQeDHIUTFySAQkwUSxHnQC/ALaVDpuatIXZGQIfaTqufiwOXarz8fbZ+XXgVbZ37fGG4LBRB4gr3RS5FG8Ph1fTqVbLdG49Jdl+Ye6HpdlenDwgqXzP2sQLSN9i+7yWfYQ1W6fAbMUnb/vkm7PW4PahiTRi3W56+VBoHLSYeCEPwvjtglDJd+4enee5je5Bqc9uZRkrMGvs12JqdMDv0lqcz4nwiFYiAx8ZzWXubPHlhvh2h0nWr8JOuywoW1o9cQAo6Snm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4824.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(11063799006)(6133799003)(5023799004)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PwNc1o402PYY0BKbBEqHSY8NfzzUTBd5Hn53RiTQO9F5lXDbl5Hm8n0Gi/OB?=
 =?us-ascii?Q?qzcUeywUI2CKYADXtMx5YBr+TehmSNR6I3994vfRWDoDsYTwZaMXnh3LZfQH?=
 =?us-ascii?Q?i8ieccKm2/tGURGRthgykIq5StPePC/HWIELMl+TlcIiw9pj6qasPeyKc0wV?=
 =?us-ascii?Q?KqzS0qDvI1EI7JZvLc5dei5bo6+xUt5vWZv4agFR2dBuh1Z51Uhkhac+G0/H?=
 =?us-ascii?Q?ryZQ+msaSy1EytxLiA3WiZ4agUPgrXbJYTo7Zy/PLEdKSz9gRG6cv2eZmjq7?=
 =?us-ascii?Q?YyJdOecdV8piA/eAtjACTY3jVErZjASoBTSZNW9QqRmsvoiZWP91xyj/F4N2?=
 =?us-ascii?Q?K9OPITn4mfpJJh40eRkXd9W/IEyKKW4DmbMKOfEdbi5F5CcU7uHUmqAhX/J9?=
 =?us-ascii?Q?UpL2h30Cew+uOBxwuQ9G98uhwQ9fnEnbtgMZqT8+8/Kde5ELO5sZ9sTQTXGU?=
 =?us-ascii?Q?n/ausOt83tJcdCw1QMen5IQH9DWMQHCgJ6NlUYSdxxcS4lu+ZgEOG3WgWDrr?=
 =?us-ascii?Q?e9kvFmEDwQgEuajED7NYozrtzJ09rsCZO0bOCl0HUR6ihPdqj0a5JL5U+RFv?=
 =?us-ascii?Q?BX3pZg0uMDP6ymT/pQto+gefr0shcWkHi6wvc4ceMgDCkYdecjzwhwHkrc5b?=
 =?us-ascii?Q?WkQoxDHZtrnBFphyscdyDu3N80J+VVEbORqhKx4p2rjV0aY0+czkYp5oakjb?=
 =?us-ascii?Q?/9cIGOec8aWElH/SlDLXMw7N4wJUcxCqk8Ohk3jepWT/fDR0v4o1gwnu3wZa?=
 =?us-ascii?Q?4pPCWE50OCGjGQF6aLcTvBg++u4nYnF6Cz//KHsqP8O+uwCdS8F2ySDmfdlE?=
 =?us-ascii?Q?s1/7LdOHOwnYakjpqkA2vTbxQ8QLCqeH1kGjRux/G4I2LOhXrSwvq+gGpH24?=
 =?us-ascii?Q?NjDUcsTKPlTq1DXq0kF7B3xTSyzW+wlBjlcJOY/IxjcXvh3MnrvYqAwrs62w?=
 =?us-ascii?Q?Hn3jrl/d8v59UDjMsik8QbDhEINfLxiNyZTJ3TBDHtoqsxGXGFn4tJca+NMB?=
 =?us-ascii?Q?ZQvT/MhXJgVkrFiSWme5HNn/y3jpIqWn2fY0UnMT+a/zpYDjsHh+sf+hsJ7c?=
 =?us-ascii?Q?h7vHV+OM+YWB3QkcXWOhFTLDjmu152QGk3pLgPkRIsgips0450xHVKItj4rx?=
 =?us-ascii?Q?Q+uP+zDoM5HXSvGX0YhRqarI521f+hs3N9pZod3Pz4fR/WzBI78QoUzFGq/S?=
 =?us-ascii?Q?sKKJdMzzGGMWCLGGqKBCRWoCRfaD7ytSvMXbXlXd49mMGFUvM5obkxwoyof1?=
 =?us-ascii?Q?8GywL3uvCP4gSU/PSC67URrM7Nd9sQeVJDSIQqXTECAovNKFbwYUrNP8RDpT?=
 =?us-ascii?Q?g/GcumoV7A98/wwnGS/dhGNrhfkRXARUcDkShO9zusNJur2R28m34+9wWZh/?=
 =?us-ascii?Q?j9UVj3X/QvRd/290u3Qm7zNkWyCUbzdA2B3hylq66QZuajhT4Wt2fY8WILg7?=
 =?us-ascii?Q?Ur+OSSAeuW3f/m8Dn7D4MWFDk27BsbbUvV5jP0x96H/Srwl6s6ym1usX75XI?=
 =?us-ascii?Q?6E03z1eDhNwF6gLomJKu9hjGFKXJWz517pgnQcwRYbKTSk/2DhJlDm2z9oqT?=
 =?us-ascii?Q?ZLbe64fDFxIYWXQQfB90RC3jgt2MZ8vlqcE2987Eou8Mk3TZR+YRsoflAReN?=
 =?us-ascii?Q?ZVCem43FiDMs/enr4dMFix37mO+SFFutM4QOVDfu4UunOEjAJf8P9lhGtySB?=
 =?us-ascii?Q?2uUlDGEOi/KM61orXyW4WqkNVXIcQ5R+bI7jwGd36edPiQPw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29af6abc-65c6-404b-2298-08debb00ff18
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4824.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 08:30:09.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3EMkjYbEuIub9QbbPb5wzMFCqJhD1hgcssEbSKjCfIMW9WoMbCx9OqK7VRbTfNOSMZbGocRERHdUeplOWEXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586

Currently, a fixed bandwidth is reserved at boot for both the fair and ext
deadline servers, and this reservation remains unchanged unless explicitly
modified via debugfs. As a result, both servers permanently contribute to global
bandwidth accounting, regardless of whether a BPF scheduler is active.

While unused bandwidth can still be reclaimed at runtime by other classes, this
static reservation prevents RT from fully utilizing available headroom in
situations where one of the sched_ext or fair class is guaranteed to be inactive
(for example, when no BPF scheduler is loaded, or when sched_ext runs in full
mode and replaces fair).

As discussed at the VIII OSPM summit in Cambridge [1], a better solution would
be to dynamically register and unregister deadline server bandwidth based on the
active sched_ext state. This allows the kernel to automatically enable bandwidth
accounting only for the scheduling class that is currently active, while
disabling it for inactive ones.

This patch series implements this automatic register/unregister logic. The
sched_ext total_bw kselftest is also modified to validate the correct behavior
across the different scheduling configurations and ensure that bandwidth
accounting follows the expected state transitions.

[1] https://retis.santannapisa.it/ospm-summit/

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git dl-server-bw-v2

Changes in v2:
 - Rework the sched_ext enable path as suggested by Peter: attach ext_server
   before committing the scheduler switch and fail the enable if admission
   control rejects the reservation; detach fair_server only after a successful
   full-mode switch.
 - Added dl_server_swap_bw() for the disable/recovery path so ext_server detach
   and fair_server reattach happen under the same dl_b->lock, closing the
   window where concurrent SCHED_DEADLINE admission could steal the freed
   bandwidth (reported by Sashiko).
 - Fixed the attach/detach accounting issue reported by Sashiko by updating
   rq->dl.this_bw together with root-domain total_bw, draining active or
   non-contending servers before detach and preventing detached servers from
   starting.
 - Reuse dl_rq_change_utilization() to drain the server, so the detach path goes
   through the same machinery as dl_server_apply_params()
 - Made root-domain accounting honor the same cpu_active() conditions used by
   root-domain rebuilds, while preserving runtime/period updates made while a
   server is detached.
 - Fixed the total_bw selftest issues reported by Sashiko: check fclose()
   errors for debugfs writes, preserve per-CPU fair_server runtime values, and
   restore all CPUs on cleanup even if one write fails.
 - Link to v1: https://lore.kernel.org/all/20260521174509.1534623-1-arighi@nvidia.com/

Andrea Righi (2):
      sched_ext: Auto-register/unregister dl_server reservations
      selftests/sched_ext: Validate dl_server attach/detach in total_bw test

 include/linux/sched.h                        |   6 +
 kernel/sched/deadline.c                      | 207 +++++++++++++++++++++++++--
 kernel/sched/ext.c                           |  71 +++++++++
 kernel/sched/sched.h                         |   4 +
 tools/testing/selftests/sched_ext/total_bw.c | 201 +++++++++++++++++++++++++-
 5 files changed, 480 insertions(+), 9 deletions(-)
