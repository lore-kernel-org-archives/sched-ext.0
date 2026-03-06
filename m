Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C64C30EF87
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809376; cv=fail; b=jiun2WIfmjVFlAyHkZT4VmtAOPz8X5jfsceZwWoHYtWFHv/BUCinUMG5c2VjqTVjIoChiYStzOGM2+nm726rR6vik94pcsDAoYvy4NoLp8BNOVGbMabJu71L2r+jYeaykLVC7792KxkqfLWz1AWcpxs6Hj2LsoGDcL/O6lcW7Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809376; c=relaxed/simple;
	bh=Q/tEHn116BqspEfr1XzF3r0DX/XTSDtW8rXrQ76IXvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rtP4bgDA9VrjWegBIlRiU41GpW8eo+bLv9YUjrDjRv/iHGaEcwUa2mhWhvNQnlqVJkOJmcd+JK7jpqZ8U5DbljEQVYrrctGlHUJmoVyDVsFNwr9LMmr7H1lYXgDqQSLkZj7XcXMD7uw/64jdJZBLbQ8dUt4ofA0TII6QGOud5AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKLlDUEf; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKLlDUEf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V37zcSgirDJJIFqpp1SloKRwvYz3q9smbUPEuhmUtmgjxcefhsBK8RYbYTA312s9GlRrRqy2L0GuTdsNWPaGRQZfQSIl3zRLIKwPoBf0XBQTvJ4St7InvKxlYj30pDrabd2gSRBxGHAoM4KZ1/6lkE5yrHq9rpc+v+xgMgfKJtbsaIYc4qZy7vc8oZAIepV3zW2piWnVGO+RRppXInpvE2yeuDRNis81mPq2gWWXK8Dk/PFlGQtsd08WO9PAO8xtys7j/sOD34XFKSh3xUiXcQh4m+s9ydGb0CUew0XohTiv4u9zD0umE9+bpJvwQ2MtOZfIcSrLsgtJBWcRf5K5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGGDvFLPIFZHK0jAmgx+sVUVdnG36nI7Qw+hT1Av7fM=;
 b=KPW2vMNo9dmCYdMpPsQkhkLgQUgTDYHNyZdDqysIOaHbKXdPco1BVLLQSoWByGwMivXkBtI5PYAXwhEMibLVNjSfnfsmOEr8XESctUPiwfUixwv2j2r+/LEaWYCaw8AXPRazT+wGDGDPd+sgpDVlEg3opOAuSUqWZ3iUphbfT2PVWccHgDJLcGw8d/sTEWZ24wr8aa3bZpwkHA2z+f1fAtfmczRXx2gEhbKYv07BDdu3NDBR/mUwFLrjIZBIMJPJ5rYXN5wBUsxXFf5u/rMqJLaMhdqym8hpWbRcYcjWASDBMSwNGbGhBKBugkB2U1mFafADnarnCO+d8EI/f3NEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGGDvFLPIFZHK0jAmgx+sVUVdnG36nI7Qw+hT1Av7fM=;
 b=dKLlDUEfPM8gg00R8r96gCUAAA0pRZ4tQDgq6iFs3zU0jYYbJoladYXFzkctKrxQ1XTNpX5N6TFOYJiQN7VwyJ5S/x4ySSFB6Bo4vla+HNniY6dabLr+e4z/QTbg8jtj65+NZIZ1BMdJavJAGox6/yBN6zfo/U73fTJYyg3jYOULhLtnP5AYF9cClw/ugkws7ZgbH8g7CS3yAQPccQSqR0M0O0b4kaK6k7S1L0bhyn2OMMg7SPT0sTQb+aq947UMEAZmAXfrwk27HKJ8ON8HzUbBd/sHKPWzgoiYtnFuXbHcvM70Hfcu2iYP9Qr15g10NSdxdf+lSFG0pxN57GwjdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:02:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:02:46 +0000
Date: Fri, 6 Mar 2026 16:02:42 +0100
From: Andrea Righi <arighi@nvidia.com>
To: zhidao su <soolaugust@gmail.com>
Cc: tj@kernel.org, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	void@manifault.com, changwoo@igalia.com,
	linux-kselftest@vger.kernel.org, Su Zhidao <suzhidao@xiaomi.com>
Subject: Re: [PATCH 0/5] sched_ext: bypass state machine cleanup and selftest
Message-ID: <aarski-ZeUKsd4ub@gpd4>
References: <20260306140325.2710927-1-suzhidao@xiaomi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306140325.2710927-1-suzhidao@xiaomi.com>
X-ClientProxiedBy: ZR0P278CA0194.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 81584632-ab6e-4ca8-711d-08de7b916cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	tn/DelUVUimo5Lly/QdJI51mTMt1NZ/2QhZoi76bCLpbINAIa7l6oMiIInVY2HB+SEdHUllvjD61LHjFM7PsPe0jF4vg5GtZ2kEdLEGiVNsak8hQODSQTh5/oQ1010Mkl2b2KCIk/qHTkLa5PoKYW/M+zFqwyOe8W2Fp5bx1wPl6pivilxLUcAsn9c1432VcKkWuI0bO7QMYWL5emxqyoNyHiDzupSib8gQwc0xPxQZMXPt4jEUOGkeWTMhvbjyxmcdz439xu0LZakGZaEgXAOwnGlPpdFMhkQERvWu4oQrRbylC9vBNyRC04UNrhv/GZwrl/h3TlXZ45FXTdz46coVyvAdY/jxRB+iq0ty85x9nKdxg6xg48/T4s1qKXnb+HpBUKN9QWpJkToHHxTNtD/6Ing+x3aJOGY74ZeXTqEDH2zMSe3QUxq0E/lmYYtYHHXDGhSVlAUuXmG5gtwQ1vXTmRCAXMGiu5PCIxtAw0kabron76jbOA/HjZMfz8mpGzPFI+QOnraDOkM7oh2HUEr30kk+qtzRZDzL0irlUfGmRX7ivG66pf+k9E0uAvxSeDvy22da3KUa79WAysT7/mf0Okb7/cgGgG+xC/BPh+s+hs/qMJD2M/Ffrzeo1omApZ4hnzgtUB4fvTvXOvwC+IXb6GU/qtf5HnNzx5Z4dLUSYLELhjpYu5BDWbfyd781TTKOF9gvO+KTrJz4032LB8Zv3wIUJYW2URxJ4jVNPtCfKZ/y4inS9q66NmF+qACdq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QoDkFqGbzoztw5WpHhScLlo7bMhMu3RcFICWgjDBaJotiMEfRg3iYL3a0I07?=
 =?us-ascii?Q?PljQIB1YsUT4rKHitG5l6Ijku/CwwLsrzEPJbr56k8ibj6htCzsunzVxu40U?=
 =?us-ascii?Q?Iw8x/kGW6eEy7m6yuB93eGXwm5DfRrmb/hlF/axzA/MLAwiGGrxvZsGnSWnd?=
 =?us-ascii?Q?aMquCIyajxcyTyxg9uC+/bEkFQ3F5MruaJmHjjwEcHA8IFO9pj0FottWtBKF?=
 =?us-ascii?Q?uEheeLc69DVx9OXaHEg5Q3dzeTJZcjsDgj8sw7c5Xn/LDc5dTvjlyJ0LWjXK?=
 =?us-ascii?Q?TZ5N8SLeQGv73ZltRCxwYCJxPGttj3RtCVN7KJVCLD+/at+7pz5rzKshxeas?=
 =?us-ascii?Q?3y/FMGrhUajkBlQNMh2j1BRdUIrJBN9UbVLGanii5Fd1MR7Ccc8NWVizFPmv?=
 =?us-ascii?Q?HdzxObUlENZaU0EXHnDaHMFx0I9WoWx3fY8+Ha4k1oVXfbjReP0sOs2EejRi?=
 =?us-ascii?Q?4NQ4w4hg7x9i/CNeyJ23Axbok7sKf+vXf569bdTEKMf4xQYEqu2KBpFzcjg3?=
 =?us-ascii?Q?zgazKhCTajegBlYgUsKK7eYSJSL2Rr99O2edk4IfcvxcdLnFatQleIaCNt7r?=
 =?us-ascii?Q?SCPbBT5tOZ5IUFqAMBlNsUoc+/5qMeTNxvkYGZlu25TVow5p1T2bAD7/IKXR?=
 =?us-ascii?Q?FZM3dmXd+oVepbB9ooprIKgaCNx7lVXogdcr/ci2/z6SzoaWPFyPdjSV7v6L?=
 =?us-ascii?Q?gSNox/MeY/UjmEKNlcC9IjKTdRpLw1lEuortJSvrEwgkP1iRb0JzDj3MTXVV?=
 =?us-ascii?Q?5qOgPRYvTzamGaoeh7otHw1noyDhSSG8JtTXJN70vjFghTKrPcxF50vXwXfk?=
 =?us-ascii?Q?949QzNQVyTiXV4b+be7ArYWFSPrSI+oFS13QHgy1VAT/sexSzX5HRm8rL/fl?=
 =?us-ascii?Q?3xIEsz+lKnf7f/xTM2cnZJxTdafywf94B7QwpOD7PFp6NOW7mwDskZChgbpM?=
 =?us-ascii?Q?zGMwpY8LOZ7ELjOT+XJsuxU+HseGcx/XIFOTpb7ttY+Qg13hNEHxgAV1Ibdw?=
 =?us-ascii?Q?4srFkaDJPxATGfieR9Sg6XQSQsHKWBiUYVPp1wjkwTk4HwIZIOW3O76fbH97?=
 =?us-ascii?Q?uczajXKf5lxH8fAmajftYr39eZYCnEi0lgKV4pdplafsdAW2SW/IHh1UizQ0?=
 =?us-ascii?Q?01lNEVSlFPhJb14gtDUlxZf7Xk1DI6gpwdEmv7PS+bJT6NJA5LbDsjQKVF3+?=
 =?us-ascii?Q?HJ3bsN/K7BQ3ZafpkAuQKTt1tCkQTabxkZIs9ztPh+iwCECikgDkcByFsWSr?=
 =?us-ascii?Q?zuKn2fAuuG6Noygh4l5iKqsxvZXoeewOjmUHwwtvPzm+M84ye+OVaMYg8OHq?=
 =?us-ascii?Q?l0AulhHeS9MvYwoSBs5SKAS02CGPXZcVrvXXMP9bYJWrsnVkg2P+RG31OrUK?=
 =?us-ascii?Q?Ta47Vg8tbNYU0yIpwksObw8dFy+ihhlwHppTW0A2mz42PbnwMlrbg0Fl1+eZ?=
 =?us-ascii?Q?wbUGtUqzua0dl1vt79nSKYN1LVnHJXkf2bpj5pS1ec8Yk4msvggg5ELUgvTQ?=
 =?us-ascii?Q?tDdqDFwCZOeSkFKDVRC9WcRW3+5MYf+RwdhRVtvnG1Rky4ni9Ep1MCdfT4t9?=
 =?us-ascii?Q?3c0xa5OYjBtawndicgwwaKRHluoFdxhkLR/GNaFmHj+STrtupTLgLIW6BY/Z?=
 =?us-ascii?Q?L5GElhNEt6xQmvmrwuvaSOrzmvutuuX4l89Qqdv3V47NjIGhPWc6YBf7F5fk?=
 =?us-ascii?Q?eV5cIwJRjZwIYymwgXCz1XLzmslaMw84E9udId4tBaCVA78f1eAuwoXRXzQ3?=
 =?us-ascii?Q?poqMJeypFQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81584632-ab6e-4ca8-711d-08de7b916cc4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:02:45.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNk7cEGHMVJfc2eUcvhM0hLibMNH0id2Bp3cH5BodeZoq0UgcA9rx30V1n1vBUzagzE+njAVNP0J0j6ZnTTCAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

Hi,

On Fri, Mar 06, 2026 at 10:03:20PM +0800, zhidao su wrote:
> From: Su Zhidao <suzhidao@xiaomi.com>
> 
> This series does a small cleanup pass on the sched_ext bypass code path
> and adds a selftest for the bypass mechanism.
> 
> Patch 1 removes SCX_OPS_HAS_CGROUP_WEIGHT, which was marked deprecated
> in 6.15 with a "will be removed on 6.18" comment. We are now past that
> point.

See:
https://lore.kernel.org/all/20260306073110.229595-1-zhaomzhao@126.com/

> 
> Patches 2-3 improve the bypass code in ext.c: add inline comments
> explaining the bypass depth counter semantics and the dequeue/enqueue
> re-queue loop, and replace rcu_dereference_all() with the more precise
> rcu_dereference_bh() in scx_bypass_lb_timerfn() which runs in softirq
> context.

These patches don't really improve code, they just add comments. Which is
nice, it's good to improve documentation, but documentation should help
understand better the high-level semantic, or clarify non-obvious
implemenatation details. In this case you're just commenting how the
specific code works, which should be already clear enough just by looking
at the code IMHO.

> 
> Patch 4 adds a selftest that verifies forward progress under bypass
> mode: worker processes are spawned while the scheduler is active, then
> bpf_link__destroy() is called (triggering bypass), and the test confirms
> all workers complete successfully.

Already commented on the patch.

> 
> Patch 5 adds a comment to the scx_bypass_depth declaration noting its
> planned migration into struct scx_sched.

Ditto about documentation.

Thanks,
-Andrea
