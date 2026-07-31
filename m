Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A996470121
	for <sched-ext@lists.linux.dev>; Fri, 31 Jul 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522296; cv=fail; b=HPVTLpo3Gu3hIzptiEh8LecFvPhLACqAKaON9qz9hTKBVK6STSTbOg/VdsMws4X53e3YCFONtvVYD/sLviWnKilZ0qMRKGE1ILjv24i8FNvgrqpUoyzq98mP8QRaU0bxOczUzbJy33+udm8UDgQ2AbaKP5vWxT7JUukB4vB81Dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522296; c=relaxed/simple;
	bh=Y+oiXYKe79Td2FdkmO7VZU1AG16xlVP5+C2TDWAJ7j4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y/1pAkvmEctqZT1tbV1eFNx8j+JTZElaCLkTqMW2vcQSNm3C2lzEiDlAGblF6l45V90XNQ/kxGiWb8K61Han2jkANNgDAw1Zpu3xdNt3D4I4u55xfDnPfrEpWSPIqxfuaELxNtPLAZo2m8fo8NO+dpLJ+/8fSI4EdYsRkYCmKso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjbtWqdw; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjbtWqdw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm9GTkF630MZR9XJZjN1+925HqKrwPnWkgd093D5P6T6AQ4aDgLGmLAkWQobB9Lkkq/ANRMz0ZN3taV9ZS5F2aBOOoJzHi5s6PHihoQelNOeG5UeovkgKXsLJUAQrEMN8ECGAjFBz/1bxGEuHGfhB9o+bQl0lo2Ye7lUp20eLehalfmTlkm8WztiSlwtGAidX8JNuXY6l8PtlaRlKWxIYAocEU+XEdehMnTPybA3gg5rIgqVu8Z1MnWfRurwqJAoBxgfNjD0acgRx8q0xZhSaS2CYVk+9odxPVIfTd6YTGARSTXS6bb7dbMC7RqxO0a3EgEcMb+vSb+mOY3SejR1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3m4RK5GQTE8nD39s/rmkGxz1VmoCN97rxrqick5sUY=;
 b=APN9rGKpVzEuhxGNlc/HtXlAuCxP8x7LVr2VM4ATXxVTZOlWL2GDjfNQvysbqcrH2Dfi1BcvWkRIlUC6mXsfB1R+kXbn8unnmZyYgfwWVl3n7u/NUy9rvy5KWzPwYTCbQtDKzK3MSRUBL/qNjM96dTdyoopSWYYXippYljL1BvNsk9egzI8ZagBCDGCi3GWz5DY9teJOC2Sbp1CM6PwZ6jIhJZeysyf7PJVmPyBS2JNp0sjW9/uUpFHz40zcsyIUmiEMk6dXThaIBGm9kN09aFpRyflGwEuDxkB1bsBCgYEGj2RBEjkXIy/aoLwCKnf88PYbKfLkWK7WsvkEGMKxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3m4RK5GQTE8nD39s/rmkGxz1VmoCN97rxrqick5sUY=;
 b=RjbtWqdwcdQkukguZgmqTDAtM0XuZeskoZW9h81SxG9449Uaz1i82Vz3HZ/Zz7s3bR6nKxWnItHWH+RBDO6kdKzy0P1AlIg8EAQvO5wmu0xMOHnZcoLWqejo763HNgOLNCWAF3DgRs3sIoEyJBEcs+kA0ByWTDPoONb+1ASBW+qOBGdjHNWgFkkTqN9YoWtDeamJawD/VaKwSLc0jBFJgH17536Ke5mZuj6yTr6w8W+7G65RxMgQa7JNq9TFO2Yu+flp+v2QSs4RiU9+dZ4VzRLQ4RsnzRZxeTWzlhGf31dmVztBF6wqUxnau8yZzSCsZWIQRuTItBLaDAz6eiOb+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:24:48 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:24:40 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET v3 sched_ext/for-7.3] sched_ext: Fix idle CPU state initialization and validation
Date: Fri, 31 Jul 2026 20:23:32 +0200
Message-ID: <20260731182406.3166853-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: a02a11e6-86c0-4fc3-f6c9-08deef30f254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8/XeI5s5mRJ/0l5P68wDngMdzi7DlJSXPkJDl34ou4f4ZMVuo0MkOC83tKo2qA3AMVqb1jI7kYSoprRd8lIDPFabks8Ccp2qPKSRzAxQvjLImYUOCjIsfLt7i6fFs+F7oSZ/j3X9aJWepcGwWFVEnz52gJ8tMWbq5Fflmm7TJkZcDDFYKoJq4YpSZJ6kZdHHx8gp57mRkxc4lt3LvRF9Xep9VuZjjKf44GdHdPIRh1EL3tbnjpq2IhPLzbUTZEk/rF0Rxefu/VkL8/Ili9w7WhezSjsy8JkoywhGdGDJiUQ8dQaDB9n4dKYSaK9Nat5KhG6zue7+UF/B2ycYM6Sr8rCGn7OG6kx6dNxIR1p946Hk0pXHmtrzFrP8RK7c6mfxnaHYIy2RU0ZRMEGeNkUvJSivw9FSu+S12K6bbMeZ1HEQBa/2+HTGwk+tzli1CKsKG1icg0Y0ggwoui+F1bz9LDtpBYOu+bZBXwzfWgXPplc7qZXk4+d0wezRjUZSvlcL2u2z3iXQZ2ZvC7hh/aZuv/Rxce/Kc0lCIm4VMSSUkL+VqILpF/sSqNbUy9YpIuUjKowiVPliJOfY5XS3h1gw+dGUEZNtVHCbp/EDsdNWdK3HBurV24E1xUgtrk1Fs0rpRJBpMSzioGQfivMYoyrlfPVDDG65P2YCBELChb+3Ce0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NbwNgZyrZMLUm6lGu5TXbOeSfVimNfnyC56hmSKhrnTVCrmrEhgTcGiC/LdA?=
 =?us-ascii?Q?uFmrTrwXDUQibgNFMax4lTKZshi2WxxLgt8c04ShscS0l3uPIduX2OY+wr5g?=
 =?us-ascii?Q?uBnCrjbcEBHQbtUw34NnbYi7E/nbhqet4lI8FNPaLRB5l9FTyb4RQEbUf7NX?=
 =?us-ascii?Q?3nHC3p6uRWN4mh+rKRzaQVVZ1OKfgLCkwUbqDH7/aWhs1k+G1IZYSdzrath4?=
 =?us-ascii?Q?rQr6wzrxoO1lV/2D4lRwGI03NEeWp/Id2FFRBYtunEe/T9zhp7uJqmsomdNT?=
 =?us-ascii?Q?7JORjxXzUS23QjAzmSRb87atspKkjBklyJejfg81pZ6DAvIeJlwU0QScd4JG?=
 =?us-ascii?Q?tqcNxAyDIuqlM8iCORqA9eZgqKlVVL/3P/Vno20OCGT/iLVQ5gXTvVjtrBpw?=
 =?us-ascii?Q?C+Jp/O76mDKItC+NtgFzkRRvnbgV8XeqXJ2DzG9+x2+mXOYLEvWueMj9QrL7?=
 =?us-ascii?Q?uMXqKvF2sh3ckXA9jRaaEYtiMN4/0qqY0QHJP0kciDuQItFkb/BgvoQ0kR0K?=
 =?us-ascii?Q?0+igDJpjWFOGkcrYEIC7pv2+Ty4Q9Loc34fay7Dp3AvJwTiRrUphLcFE6A2b?=
 =?us-ascii?Q?IDt8lJCdz2WzBbF1BbUNkeCGhGihEOkfRlUTqr/ldabfQvmJ4YUS/uzyK3OH?=
 =?us-ascii?Q?tF7xIZJj5J6CeGUE1JAPTDBUC+uHfEbhynuYh4aeNJW5VmfX26k6gkSAfmIf?=
 =?us-ascii?Q?zo+zNZDAw4ZgTSEm+9vnSsz3dajxCHi/9qLQAFAXHOODQc1FkLNS6je+JMF9?=
 =?us-ascii?Q?7nWszJSBvo1a7LKhDFMgau/WXfJnZ8V2oCq8T15Yaa+KB9g3A9emiY+UIHZ8?=
 =?us-ascii?Q?Q7JCe7VuI3k02kNiaIQfOixz3ck4XLSbZPEKtHP2HoVQMQTyC2d9J1MdAvUp?=
 =?us-ascii?Q?exPTnZDo9F2JvTi2zyHoRMIaA0M/hUnCkBVMOhd9uJW6hPToeJDxiliEjIHL?=
 =?us-ascii?Q?5UKSGEw0Va4N7VdIRNDNHkSIl/8X17+BpJU2bDWgMGILBzfmm0pKajLOalGg?=
 =?us-ascii?Q?v+hxGTa/YhFzVS/gR7TWlxz5rNR2ojnmLaFe73/bVuPzfMyU8GycJzqDWIcq?=
 =?us-ascii?Q?W7PKkHJqCrysPNNKJFbOTPppIs52CCeEFY/av9pjQ0ZF9BBV6rOYYSai0w9w?=
 =?us-ascii?Q?1cWQ0Daku4RHm3oQl8bCwPbd9ums4FWtEy2Fqri4THSwJcSg9i/OKCEoe54x?=
 =?us-ascii?Q?rBtf9yU77BEQXyYTndMZeUQ+iZog6WwNMBWbvkaCzemw8cylr7ttmzXL50x6?=
 =?us-ascii?Q?5XdK4jkZy0WpgTD4CtuTAFEQ9BD4qiwEi1aoOHU5SOTRKcGdvOSjDTSZXmx/?=
 =?us-ascii?Q?gucPh3T3IleLkIznN1BK1+fiI/gDAuqzCjKLVZc+L8E23azRp655cXIcbjD7?=
 =?us-ascii?Q?8f/XN6IS3Uk5vLrvo35NIlvZ2tmzg9Eud3rgfMY1mzoOa5ZPA2y8VYx5ZSMC?=
 =?us-ascii?Q?iFzb3ulUF/TsHsyFvpy5TOymyTJOOLPHQkKBS9UWIJmo+Is23de4Wg4N9BZd?=
 =?us-ascii?Q?O8DiLxyV40fCtrBCO7ESaT7hEejk2m3JCkt1yvC5oWj6iHW41eBObtIfh+MO?=
 =?us-ascii?Q?LAWkJ+/jEEFcqLBDT8+RcufF9sZkEg2sAqPO9JplKH1WU2WFGnBaF26LAgmJ?=
 =?us-ascii?Q?PutgRx5NxG4TJAgK9lQoHNh7IiUx55j7CO4700VzO0UWCDa4flGNPMesG044?=
 =?us-ascii?Q?ANatTCsWc+qN+sayr+k4kF0EvSQipGIX7sd0ldSsgax4J7etoZtJfqKV/h/0?=
 =?us-ascii?Q?LS6/qVMfOA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02a11e6-86c0-4fc3-f6c9-08deef30f254
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:24:23.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsBU2PN61ExXFTrDs3F+zt6ur+bCNVpAMqJ6q31hngXsYigln/EIN8MI8BiA2GhnM9GxNdHygzA1fP3zYa1MBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

The built-in idle masks are initialized with all online CPUs marked idle, but
idle tracking currently starts only after sched_ext is fully enabled. This
leaves busy CPUs incorrectly advertised as idle during ops.init() and until
their next idle transition.

Moreover, the allowed_cpus selftest checks that a remotely selected CPU is no
longer present in the idle mask. An idle-to-idle re-pick can re-advertise the
CPU before the test performs this check, making the validation inherently racy.

Fix this by enabling built-in idle tracking before ops.init() and refreshing the
state of every online CPU under its rq lock. Early tracking updates the built-in
masks, while ops.update_idle() notifications remain suppressed until the
scheduler is fully enabled.

Also rework the allowed_cpus kselftest to replace the racy remote-CPU check with
a stable local invariant that relies on the newly reliable idle-mask state.

Changes in v3:
 - Reuse the built-in idle-selection static key instead of introducing a
   dedicated idle-tracking key (Kuba Piecuch)
 - Check the local CPU-idle invariant from both ops.select_cpu() and
   ops.enqueue() (Kuba Piecuch)
 - Inspect the idle mask without modifying it and perform the check before
   calling scx_bpf_select_cpu_and() (Kuba Piecuch)
 - Link to v2: https://lore.kernel.org/all/20260731090334.2911948-1-arighi@nvidia.com/

Changes in v2:
 - Move idle-mask initialization from the selftest into the sched_ext
   core (Kuba Piecuch)
 - Add a dedicated idle-tracking static key so transitions are tracked
   before the scheduler is fully enabled (Kuba Piecuch)
 - Rework the allowed_cpus selftest to validate the stable local CPU-idle
   invariant
 - Link to v1: https://lore.kernel.org/all/20260726064754.378671-1-arighi@nvidia.com/

Andrea Righi (2):
      sched_ext: Initialize idle masks before ops.init()
      selftests/sched_ext: Make allowed_cpus idle validation race-free

 kernel/sched/ext/ext.h                             |  5 ++-
 kernel/sched/ext/idle.c                            | 35 ++++++++++++++--
 .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 49 ++++++++++++++++++----
 3 files changed, 78 insertions(+), 11 deletions(-)
