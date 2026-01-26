Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64730171A
	for <sched-ext@lists.linux.dev>; Mon, 26 Jan 2026 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421682; cv=fail; b=YxocttrIuuekKeoPlS10Ew/MKmC5Hs7iVRuh39pWza9ONLRzxNb5p2Saw0SXt0OTNLwyejFZ8VK5Q6qXg6pqgO6LuowjLJgGbv3hqGQxP9GDdRBbMu9lwWvuAYOhgEUntC3JaXC8kLc6QLH1490LKe5OLR3cFSMePZei0EdGhA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421682; c=relaxed/simple;
	bh=7sanhncHI+5xWPwfXgnFE0JEQ7eeZ1+Zi2dOqgelDIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PwfU15oy7AWAEAIlbvVp3RBmkIYR94CC8XTTEWCI72IWome/esro8MPx1TXYn5TqUEuK8m9HOlwDMictNyS3iU19naYMVzQMMdffB/Ap9e/FZ/HXHXwJsCsp4Ag8UTJmZG05Iwbn8pgGRwJZbHkM2XbVMSOhEhTYylwLzsSSt3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=glFHEDBJ; arc=fail smtp.client-ip=52.101.85.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="glFHEDBJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQwH+b1uzl2MXPKPO4ofqBCiBwwjvNjbRZNF9dKBzztmjkFIuVxk+tQfCHceZVXouYdboWzOp7HPaRvmJvPJedySYt5aJYE82eswxQdbJM/CqgPJ9QW0nW/Y+byLCxd/V3WuBJ5szzC6gTIQrBsqVz8XI3eZAoakzGKrp+O5cXziQX5WDKzkAu7l3RQ1tP/TY66bRCweaysd0/pZIY51+nVALWy5Dad+aG1DRy9416EpReI9+4IYCxSTqE05XI3RZUx45kLNFhXZa4TCS3bzcmwcdopanqW6sDHsJOdNadGg/7kOvtrjyy38Z3+pE7T6lC22p9Zgxb+MkME/HN2Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyzwJAL1GeKxKZS8CcUAh8YMWDcv2XdPNQ4kWzpmFXE=;
 b=zGLKEvw3A39qGMWt1Vbvv+6sKoRADL7wTH+/fiWUxs91LgSS3f06XafORMOPNulXeCdU47c96mj2UIl7AcKHVMLvbjtRxOIlq9FunGpm1jCN2L91D4edsJx5eQBt/fkAV6uGRx0oXBvE0MqFa9cQ/aDp283OgZ/rGLsZSSDCZY5MPW884wl36Mu/ffIVwIrfmNyH17BkR3M+LDjLEdBQCOFLSPYDucPI0nuygInizz/lsnt+t2zoM0luO633rh4Z+sHBPz6aQDDllEbC3CloHJdogXJ+SgSsNQtgX6bxPPfV1YLj42toK3l/6Qm3F7W461qlM+XU470qqAlT1vBaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyzwJAL1GeKxKZS8CcUAh8YMWDcv2XdPNQ4kWzpmFXE=;
 b=glFHEDBJeclMgLxmBXPI20ymXiVPNzHHxv227G3ItcYE88iIVKBUksS6Psvb+jPS1I3lroEJHJS8zZDauW9OWX2ilKTgMV5H66v5GyllhLOPmUdZhX//KpQWZRvxPcsuBBHTLai3QCOC5uxLtt/IsEamcY16RWiYaEEOeVtHMterErFxYHs5SZTU7YRfiD5bM8Z67ycI1jptbnzFbC/Prw7Odnx2/e33KtPKg7uVPS4eaXH6omfaF/wQRMeKmN3CWuL1zaiRODO/YolRxsOdW30hXKVXsNIqbufZ9WNdMRB9w+7ZBR8cldLWYGdw3ZDpHqo1+qpzJ+C3dY2N2xGIOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9615.namprd12.prod.outlook.com (2603:10b6:8:275::18)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:01:13 +0000
Received: from DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15]) by DS2PR12MB9615.namprd12.prod.outlook.com
 ([fe80::f4e9:9ad6:cb62:2c15%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:01:13 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Date: Mon, 26 Jan 2026 10:59:02 +0100
Message-ID: <20260126100050.3854740-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126100050.3854740-1-arighi@nvidia.com>
References: <20260126100050.3854740-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9615:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b24e25e-e198-48b0-f7f2-08de5cc1d689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sGc5joxeIaYJ3szNck8BuPsZtcD/pPAkoaOmSha2KlAqeRG/lGSeeGuTD49l?=
 =?us-ascii?Q?bLFIqoXbeu8bPylPfUswa9sGArgIsyWzU+wbDaga6iuWhL1we0l6vNqwzDYS?=
 =?us-ascii?Q?c39iVlrkAOm5kpnm+9qULlVJ+p/sUSJovGByaxQlC0c50fTVf0QyswGJ0M9/?=
 =?us-ascii?Q?izPNNfWvYZMNSN0IAse4ADJaHyppnxgJ2MC3R9mwusj9a8TflPzSQSOWRhu4?=
 =?us-ascii?Q?PfWab5xxdawEP1lSsDvzWl2EgV7qogQtwhcWBBGmjmP/PZsoXZPdnbykajD9?=
 =?us-ascii?Q?ZgYHU8SHfM7EN/UINAJnb2KJ76IVk7OjTAcurcwRqRbvZP21CMFnkMV/zaBm?=
 =?us-ascii?Q?Grvq/XXF6yNYVttT8/pFTwqSH+iwvZidartcKj1OktNp6rAMcyoZB0RBQ2pC?=
 =?us-ascii?Q?dOMF680zXwVk0orselRL1AUWTykEs1ugXJq1a+6EKFHOwYYQFlAKeu3DWdFb?=
 =?us-ascii?Q?MkfGmbq0UN9Edq471RooLcTZFmYriC6ToyqT5QGS/juQu9+Op4DoGuqEnPYS?=
 =?us-ascii?Q?k0r6VfzEi7By83BwQ4mOWX3cInOsVD/foAyyp76KlKbwRiU4Xwrm01OASlIm?=
 =?us-ascii?Q?0t38BAjwh9rTzn7pGS8XwsWSBD8MOMRqGPHxmkU0m1ZR4E93o+Mh+ANiQkMJ?=
 =?us-ascii?Q?BIa38PYbw2ky/vzcXcFOj+pPc5jMdvf+bLPBXmfHr+wI/x0N099pB+2quKmI?=
 =?us-ascii?Q?cwfnzHMwwjhUF/Dg9ysmiOfrTmfGx2aN8wTSj5QMbam2sLamjxCQXLt1pHtx?=
 =?us-ascii?Q?E4t5Hd7r8d3ayicB12meJZSy/oLfTP+IRREP74iMvXAXgeNdtta/+RDXLH8H?=
 =?us-ascii?Q?F4Fty02wT0V5lrFV4gsfvDSg0AuGronyX/FQaYWF6tNfT6SKDT3xULCHfnCf?=
 =?us-ascii?Q?fiePkSna9Zo4wD+NmTL0BDdQ3gsx0KXDNbN5H+821FXXWyJmITsJEmXQNGJO?=
 =?us-ascii?Q?fhx6XFnxBaZbhfkdpKY+PdUKP7mhJJx9YcfjpQvXq71wXCqH/egpNHpm80UB?=
 =?us-ascii?Q?iGgW2jUsnov3hWpHSlrTadBL6JR6AePhh2FYPv7qhRQ+QMVIig1XL3PPctYh?=
 =?us-ascii?Q?yHh/pl/JP37tD9XUcr6uMHXcwOBBUPJ9r7P2aRSPC1s78QYM+icpctrZdjx7?=
 =?us-ascii?Q?R36fpVmmMhzmjMKAGIB8sDB7D7YxQrxPU91Nc+ax6nZ9vvTitKXttrg9XNWW?=
 =?us-ascii?Q?Xoj+NVr7Ls/P2H0Ley29GPrlkZCdgCMfToEg2WBZaTER5CqVkeMlhoD1e8Kk?=
 =?us-ascii?Q?pJFq4bKdJlRojZk+qz0CVBH00pQMGt3maAabmRAfxSCNSldYg6YJ0qfopTe8?=
 =?us-ascii?Q?yWHzsPdXkimHhGbLGirdDsjywXYnvOcLYxqUoJAshT+Ab6jyGZT8lA4W+2dE?=
 =?us-ascii?Q?CFstp4nGlbK37/5cHjQRX53NrowuNZoUz8tDxGO1NsDX8VVcellC2wv/BdqO?=
 =?us-ascii?Q?gnwgZpbomM+Qv24fjn204/f0YoWcmnAdVPw4hRYBD/iLrcjmCjGeibi9LdgM?=
 =?us-ascii?Q?29s6Lz8ZxfWOKCzxuIfMT7lKCugyBb8ttQw2X4QbEyC9Sq77bYM9Ia+7UZN+?=
 =?us-ascii?Q?McL7oQVYr4Y2sUGsF04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?neD/6Zue4vmKrx4SGhpCSU7T7kMfD0YVNKO9cKSaNBoaUVnB1DesgiOogA+l?=
 =?us-ascii?Q?+TKr1Dhs+bc7pP+i9rkOZMCNwxtF5PEiTbnn40G4GZ7zcPlhOWHJaptrXiAs?=
 =?us-ascii?Q?cegX0u4Eq+I6YO4Q/tZyzHVbpER0bnaArn/ytpeNDzkMUqo56sey5dW/GACj?=
 =?us-ascii?Q?IZwUa/MM58VVc9uSguMgKHkNeAmRpR9KWxllfSDgZqAQqtXg1PLyx0pdszSB?=
 =?us-ascii?Q?kdN8/F1kaBxOfoprRxNnQmzFiJsNw4PvjQu9YrjTS1NABw+khwDLSQWxLIWV?=
 =?us-ascii?Q?mDc9w4jt2mX5pY/okLp7qsSgU36k6UaeYIN2tKz7KqRWhJf9Zk6lIkxADHWa?=
 =?us-ascii?Q?iZEkZhC353QJw59V7q6ydg3ebLYUJxCqvr2R+yDIEDR418x368CG5Pg3+cLz?=
 =?us-ascii?Q?kx/QYrSeckWF8mmHD492z9gKDpASoTBATP6t2cNDSzoRohPnMB9PaxffXbh7?=
 =?us-ascii?Q?D/hnQD4FgXjzKdVW+pKPuAxTuRvZaDQgqOp8bqdsuTEHq4Fv8ynVTdB+gJTI?=
 =?us-ascii?Q?ND8/Mr9gmjHWW4TzRPGZJlt3CWFIZMmQ1JgPbnBxjJvNFS/msCyiPhkFc6z8?=
 =?us-ascii?Q?S9ghpqrz8ptFO9fd0nRLn6sbGX8kLjmsolxjtBltgq0Je74NLy5NP9E2RPhX?=
 =?us-ascii?Q?KdibHHO/HWlfGffzB0MPUAp4T70ZnqIl2Tt5oUt684VcvYEpS7B4Lj0oW5SB?=
 =?us-ascii?Q?LhlaPSbh1R4WP9+UMZIUEdjysxtXq29UgAT8lXvxPiV5ZKX1gBcU6G8/3YNY?=
 =?us-ascii?Q?G9wwGJTvrz8y4Ldhx3xS0OyZcjKIYY9stjOGk60Yd+WTjKdz06PjXkfHPUUo?=
 =?us-ascii?Q?eSwqY8+M/2BtPej0YoeCFH3HwsEA5H41bnnGXukeRtxR8MQhIdCT5zfW/0Z0?=
 =?us-ascii?Q?qk6uzCSCC5aniBta1Ld2iwiuqu59JcNZHa8fWhWU3dPhvjykGlzuV54YIPMt?=
 =?us-ascii?Q?0mu1di/IZLry7SRAEvYFTqeLPemUuFSICYpekhdq4qFXXsAHABbmuO9If2ZE?=
 =?us-ascii?Q?NRCGgMrqal/628XhlG2BDEgeBlsXDjLDqyc5jRyFm22vp8HeYK08pwaADw9H?=
 =?us-ascii?Q?oZSd1CfuaeLFWH3Pg48wOu3HYE+S0sY6H9SKSmtposB3Pb1hDgTGxGa8nscI?=
 =?us-ascii?Q?QNM/4lFjqNnXfELbVOoASRf0BNxEsli0WToHwNSjKCI+IH8163DpkOXFBYVS?=
 =?us-ascii?Q?UYT/FWLOS/mzKuzRyzbIVqATDwMN44HYv6Gas5e1cMTR07g0CTJP0QG20ym5?=
 =?us-ascii?Q?YTvCxtDoF2aeH3CAYyX78f3T/hs6c3BGDXw1YppONHWNTzxZeTKfasjO/pk5?=
 =?us-ascii?Q?OPDHvEX32xOgF18jo25YdLSye/Y43dPhTBXDU9LHqVkkqivUJpdLYqMICvSc?=
 =?us-ascii?Q?Dld5p0Okmc0BXHksQbdfR0hsaBuE3m5qqkCxZZT9Jn/Io4zr2aaWyLLQ386U?=
 =?us-ascii?Q?vfQGv1ys8YG2WwnLiY2wUAUF1mJPSTOn01oLi4megPw4xvntqWmsuxY7oabg?=
 =?us-ascii?Q?tT0qnJQyVkfnCjIfDr7AylXMxMX4F/SJsl43kWZ2ceCvE2s+hC/aL4iLagWH?=
 =?us-ascii?Q?PuyiRQqwhZvKG8j4zPCQBitrKhoC/y31kE1WY6dz0YpsAQVM58cJ4pyTNtxe?=
 =?us-ascii?Q?5+XfNvUBabzywXYsoiWpRaF7r95n+noAdmeJ/u5P13Hs2fUMG/EnSantJV8O?=
 =?us-ascii?Q?w6QTrlhdX38jP4YVEev9cGxvhYRXcYR0i4Y+81q+ysP2SHNI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24e25e-e198-48b0-f7f2-08de5cc1d689
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:01:13.5239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xO0aNWp1P50Qd5dBDXCX/k7RSMqETa2fzepOMolEQyYhjKEVb23XQ7G/+IAWm54yRopbNb2HP8mroXKN7eOUTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also included later to confirm that both DL servers are
functioning correctly:

 # ./runner -t rt_stall
 ===== START =====
 TEST: rt_stall
 DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
 OUTPUT:
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1511) is 0.250000 seconds
 # Runtime of RT task (PID 1512) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 1 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1514) is 0.250000 seconds
 # Runtime of RT task (PID 1515) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 2 PASS: EXT task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1517) is 0.250000 seconds
 # Runtime of RT task (PID 1518) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 3 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1521) is 0.250000 seconds
 # Runtime of RT task (PID 1522) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 4 PASS: EXT task got more than 4.00% of runtime
 ok 1 rt_stall #
 =====  END  =====

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c     |  6 +++
 kernel/sched/deadline.c | 83 +++++++++++++++++++++++++++++------------
 kernel/sched/ext.c      | 33 ++++++++++++++++
 kernel/sched/idle.c     |  3 ++
 kernel/sched/sched.h    |  2 +
 kernel/sched/topology.c |  5 +++
 6 files changed, 109 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 045f83ad261e2..88476d8b4e3d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8477,6 +8477,9 @@ int sched_cpu_dying(unsigned int cpu)
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
 	dl_server_stop(&rq->fair_server);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_stop(&rq->ext_server);
+#endif
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
@@ -8680,6 +8683,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 28823f7eb8667..fda77512c6e47 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1443,8 +1443,8 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		dl_se->dl_defer_idle = 0;
 
 	/*
-	 * The fair server can consume its runtime while throttled (not queued/
-	 * running as regular CFS).
+	 * The DL server can consume its runtime while throttled (not
+	 * queued / running as regular CFS).
 	 *
 	 * If the server consumes its entire runtime in this state. The server
 	 * is not required for the current period. Thus, reset the server by
@@ -1529,10 +1529,10 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	}
 
 	/*
-	 * The fair server (sole dl_server) does not account for real-time
-	 * workload because it is running fair work.
+	 * The dl_server does not account for real-time workload because it
+	 * is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -1567,9 +1567,9 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
  * In the non-defer mode, the idle time is not accounted, as the
  * server provides a guarantee.
  *
- * If the dl_server is in defer mode, the idle time is also considered
- * as time available for the fair server, avoiding a penalty for the
- * rt scheduler that did not consumed that time.
+ * If the dl_server is in defer mode, the idle time is also considered as
+ * time available for the dl_server, avoiding a penalty for the rt
+ * scheduler that did not consumed that time.
  */
 void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
@@ -1850,6 +1850,18 @@ void sched_init_dl_servers(void)
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+		dl_se = &rq->ext_server;
+
+		WARN_ON(dl_server(dl_se));
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_server = 1;
+		dl_se->dl_defer = 1;
+		setup_new_dl_entity(dl_se);
+#endif
 	}
 }
 
@@ -3181,6 +3193,36 @@ void dl_add_task_root_domain(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
+static void dl_server_add_bw(struct root_domain *rd, int cpu)
+{
+	struct sched_dl_entity *dl_se;
+
+	dl_se = &cpu_rq(cpu)->fair_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_se = &cpu_rq(cpu)->ext_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+#endif
+}
+
+static u64 dl_server_read_bw(int cpu)
+{
+	u64 dl_bw = 0;
+
+	if (cpu_rq(cpu)->fair_server.dl_server)
+		dl_bw += cpu_rq(cpu)->fair_server.dl_bw;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (cpu_rq(cpu)->ext_server.dl_server)
+		dl_bw += cpu_rq(cpu)->ext_server.dl_bw;
+#endif
+
+	return dl_bw;
+}
+
 void dl_clear_root_domain(struct root_domain *rd)
 {
 	int i;
@@ -3199,12 +3241,8 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
 	 * them, we need to account for them here explicitly.
 	 */
-	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
-
-		if (dl_server(dl_se) && cpu_active(i))
-			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
-	}
+	for_each_cpu(i, rd->span)
+		dl_server_add_bw(rd, i);
 }
 
 void dl_clear_root_domain_cpu(int cpu)
@@ -3706,7 +3744,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow = 0;
-	u64 fair_server_bw = 0;
+	u64 dl_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3739,27 +3777,26 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		cap -= arch_scale_cpu_capacity(cpu);
 
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
-		if (cpu_rq(cpu)->fair_server.dl_server)
-			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
+		dl_server_bw = dl_server_read_bw(cpu);
 
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - dl_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap, dl_server_bw, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afe28c04d5aa7..809f774183202 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -958,6 +958,8 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -1501,6 +1503,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	/* Start dl_server if this is the first task being enqueued */
+	if (rq->scx.nr_running == 1)
+		dl_server_start(&rq->ext_server);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2512,6 +2518,33 @@ static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 	return do_pick_task_scx(rq, rf, false);
 }
 
+/*
+ * Select the next task to run from the ext scheduling class.
+ *
+ * Use do_pick_task_scx() directly with @force_scx enabled, since the
+ * dl_server must always select a sched_ext task.
+ */
+static struct task_struct *
+ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+{
+	if (!scx_enabled())
+		return NULL;
+
+	return do_pick_task_scx(dl_se->rq, rf, true);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_pick_task);
+}
+
 #ifdef CONFIG_SCHED_CORE
 /**
  * scx_prio_less - Task ordering for core-sched
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index abf8f15d60c9e..d6b4cda176ccf 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -536,6 +536,9 @@ static void update_curr_idle(struct rq *rq)
 	se->exec_start = now;
 
 	dl_server_update_idle(&rq->fair_server, delta_exec);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_update_idle(&rq->ext_server, delta_exec);
+#endif
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 93fce4bbff5ea..d630f46325379 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -414,6 +414,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void sched_init_dl_servers(void);
 
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1151,6 +1152,7 @@ struct rq {
 	struct dl_rq		dl;
 #ifdef CONFIG_SCHED_CLASS_EXT
 	struct scx_rq		scx;
+	struct sched_dl_entity	ext_server;
 #endif
 
 	struct sched_dl_entity	fair_server;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cf643a5ddedd2..ac268da917781 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.52.0

