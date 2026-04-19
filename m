Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9DD2701C4
	for <sched-ext@lists.linux.dev>; Sun, 19 Apr 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776623503; cv=fail; b=GdqoHstLlyt2qbAgeh/NA6oYdQkpBBnM8/JBwthBAsRn0dgmhZzXtzjGhdJBBjYICdrRRm7pf7RPIQXY8KGAnit2G8nG/g12uR11wig5DsoWXau2FGTa6eIb8vfKtbNmG3mRkyOLNOSnWuJhwWHbt4ctwL26jRX8e7uty+/WJLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776623503; c=relaxed/simple;
	bh=EXITGCLKIolOUCzJPEMuIFdJlTYZ6KWNIa+t/SwspMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZfcAoYA0ZcbH/Zy6q4/3i6zcJJonuHMeMj4i2ELUtGs6fDVq1pjHGZrOmMQPZcMR8yOpqdQnEzq8NQcsbSTPyxypzrwdBFlg9psOlGSQsSgd1dwEDaq1pR400viS6vEhk2qI+3xyjMLq6r+GdhJn9S/G6hToclIr7rRhXYbxafk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d9ajo26k; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9ajo26k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksURVnnh0OGnT49VyR8UxI0qMHu6xKwsTEoW+r2pGo7VTDyaZqS5FgfYLtgW6aqytcRHMJQSqh0LkuHE9pcEd9j0+TqOBqcw7nJbFxcL8g6WWGWcDNH7GvUQrj5m8CE79gqTxISl0gQXsC8KOeWVkYYJyLNDOgaWBLCoVXG2DLJK4ncVFPP5fBDMxNn17lMrs6s2qrQhunP6VfEsVlStAsMua2wCnUZwDfJPM89SM4zKSaGq6YwJiVPsZ9pCR8D4dfrD2SgJazgHMXB6OhDquo0RwBG2p3hxhKWYASN5oBG9bwv8zDHP/LqMD32PTkIo902cSHCytGx6x+jRO/5AYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY1y9mfBL/YLi6YLVe5DAYp0Iqbgf8TG6/dmhkMmYB8=;
 b=FLnl3/i+pBpMmy91cAWZWyryJFsqWHQLL1D5AHTunucxSHqryYuDwjZ3SKN6AJjWCZyz+LLzE4QznLNh+QlTwvd9SNrmDTZ0D5D5iwKWcavM9OUO9qTyKZcFpovpJCe46SjUgBZQIX40ZScrxgAge2b75DSg37hyb22i+zSj2dpUIXXdxotzRLb89isKB+gSdDw1ZDEHeKT9Q2vNwvvhVVsmLY2I3fC6dHruS5sJOboSBSLy/d4TzQBrTkDflucQyUHcnPWkto7waTeucqfHjA9b25XWGmZx0Le9EzCLpQIDMGBp/K78uM/8RCtwsVPoNvynEEDl81h5MgCKmTJ8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY1y9mfBL/YLi6YLVe5DAYp0Iqbgf8TG6/dmhkMmYB8=;
 b=d9ajo26kRHf1YGwWs7VLpxjQLrz8DXBqK4qoySTDyvWZV1pvwvTSMOOqYE5ADXDDHCucGS6R7u80QkNbqXbVk4fLF1rLP4zVBsEaNejRC5sg5mcFydIUAqJ7YOdZaLowmjRNfyF2sv+IVAG9RUhnEvncYc/JNB2BPhGy33DyDxIJXs9SLddZ7qLMTQbpxDFVuJUGyWcS7Jey0usK7tUm8a7T5jvyGEGBbu9D39LcUROZaifI3crPT7BzhtTPBRswp2vAtBlT/7AmVQVaVctPmp23zYdbNtfQAokvG+9qnllBWOPu6F9GQhJ5Z8PyHiye8uocM+BZnP/lYAa79Kghlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Sun, 19 Apr
 2026 18:31:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Sun, 19 Apr 2026
 18:31:34 +0000
Date: Sun, 19 Apr 2026 20:31:29 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: add p->scx.tid and
 SCX_OPS_TID_TO_TASK lookup
Message-ID: <aeUfgbeUevwfvcXI@gpd4>
References: <a19c8c74d7c767bc9865b75d6de7c723@kernel.org>
 <aeUKt4Mv7NPZIrLW@gpd4>
 <070b4b9e6b56a0c9e2e61423f35837b4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070b4b9e6b56a0c9e2e61423f35837b4@kernel.org>
X-ClientProxiedBy: MI3PEPF00004EA2.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::452) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1122d4-86bd-4e78-866a-08de9e41e258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TgWcRpI46GIw8l3chIri5fP6nbq0xmbToWjaIYcdcg13qjfQzLU/0bWwYqGPcFQq252a+4RowLDpS0xZU7R90FOGMfJJoNIuJOpupbIa8e6DJa0ZuOYQ0lcxbKew9pR82FCfUK1PS0/LxClBQ8lHCRk6Ck0s07kwX9EPGuGVhPBJls2IAeGlfUj1yBQo04QZfLz07/NvNTYY1D5w4GB6nfcvG4O8GIsu5hbxPh+A4FBD/26UAPvhcXy4IVP2Jo/tK6mFerFYEY4BcOV7ixrGDDTUU2hG1U5281BHo575vg2uS70NTWp/gtGemNU/GiYafSZBruTdFujnuvo9w73hHZ4HUQFy15uipItdyzCme4wwDmrPMUlSsbRa5kbmMdbYL9cip4yvznmBbbTLfrUhxri17NM9aOJfgNf8leSDl1Lg3BjXWWGmfImD/hZRt/ZWVvIiJn4FLh03d38/3fCSLgf1gK3irGwqY2hCzxYcXS7XNivctu91bRdJoCxjjpTs05nfSXPDyhb5PFbG01e0u7hVGnv7coG/GTc4DzE7w9FthSPPAYXfe3nmt6ME3bff4fLgRLZ97qz7YpBVd8Q853QR3tZTqIwl9c2muY4KR7Qy9ddTfUJ5+T++9JZ1DE9unEEC2LO910UqvVNW94bqPV9QzmaLO7YNWFL+yawepJtWamaJNEcrWKMZkgGEc/qc6iKwcA4tD5oTigLkTlwe9dhaeGhr6IR6M7qELFCcWSo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UgBt45aBIqTPwKpLYUA3mtpNST422esnfOkpplNYVsmgXklOqvG6i6oCy7KF?=
 =?us-ascii?Q?y6qWar3eDPtgVEF4rgxd1PD4aJm5AqPO8KUVgPV3OBhxIr+dRVVvBXRU1tbH?=
 =?us-ascii?Q?8E/fp8l+Qb60J5GwMRl9l4SiCG1+CfVsSzyqCucMvCDYnYiWjBsPcKm8x3FK?=
 =?us-ascii?Q?Y0CqyRZgw1JgOngEfInCqr71a+abxWlYNNubpQY9GGMisrg6YL7o7pCDhL3v?=
 =?us-ascii?Q?wGsEroSwdpErpyEo90dc1qjae/gc1XLgYmnVuBbEmwil7qlYTDoh7M9XUn29?=
 =?us-ascii?Q?4DiYq3sehWBL9bzlIofyc0GdPds3HM2NuKVEbdJgPCQbmR31nTQDYwN2tKE/?=
 =?us-ascii?Q?lZfM0TVF5DBbMW6W0pgzgpILIfVqXMi+xafxPpZtYUFRQLoBD+OmwsNJRXwF?=
 =?us-ascii?Q?PP6YJANyEg7Ph3KIs9+TcCmKWdhB63TLREPCPJs5OnXl1zzkiIAYYWhfiWjA?=
 =?us-ascii?Q?WeFjk95hRCaoPyhrmZIQQTUvcH3ArbW/hTGX3WyS5Hj0WgST74gj0QUrTlcI?=
 =?us-ascii?Q?nUzB2vghMyw8rCaj5BIrhmZFcEs7yo8coWeHCUAK5W7DKNYGFvogtzGivUe2?=
 =?us-ascii?Q?oTJKEF7VGtNy/cRp/nsTV/HqOUE4DoiSw4yPeJpnLcNoCM0/j668iaEgOUT2?=
 =?us-ascii?Q?Mjolcf4zalN3/L9CWXYGTgomgz+YYK7xSy3o2fg/fEROLCYJ088BKUFSRgm8?=
 =?us-ascii?Q?8FF/LeF+1fzANjE3Ax2Rxto4Jmp0qWGyeFr+CZINITk6wbf2qC7ytxgH2Bf0?=
 =?us-ascii?Q?8/tBlesqNSKzPEt4n14iUP26y+5fiZCMMkoKt2Yb1qJ60S/MDdFqDqTMd1Jf?=
 =?us-ascii?Q?0e0JHHH25EuZoEUvSXeJMRvrDrAsdbB7kzlJx5aJNWw5TKQewKo2cXuWdTyZ?=
 =?us-ascii?Q?rRiPvzWWdCxbcReA1ojD2nrVGx3pQ3s40I2ItjsizRfHYHItg9z1ugejc0zX?=
 =?us-ascii?Q?mal2H3UdNXXhehvtzJ/QwWTT1eBGppUHQVGq+dV61HbXPZF9cfwvVFKNvMt+?=
 =?us-ascii?Q?Q/fjE7gz5c1MVstVpsPfqOs+6pL/YLMjuD7o6E+MHYcBv4PG7a4NHZR3V3g1?=
 =?us-ascii?Q?h/sfv+UpsMUmty+q0goNSxL1cyL+++7FwpOUOBed4QifP4T9OoU9iQ2wDWhy?=
 =?us-ascii?Q?PGiU+ljyg4HEhdbYHBeBGN8oaIKwc0+0wWt+OhMNoRTyUO0CSB9ysw04e4SE?=
 =?us-ascii?Q?YbPrb2XP5y5uPLrLDejM7f75vH+0On0SCkAvbvb7VWcSWWBE992ODf6mROgU?=
 =?us-ascii?Q?jV+s1FBikVicMNhNoHVlvW/80mOeiCzxeC9ZdgHbcerV/POzY+wJx3x188Z4?=
 =?us-ascii?Q?5N2EIs48fom/xWNga3DJWR17hVF9JcvxyvJEaYqbFT89M2c+0Dz6xt+7y1DA?=
 =?us-ascii?Q?V4Xe+AXulNSJut7GCbEwfjSHZXo01LyG4ymi1lfOy6uZ1DHE0viN44p5LsxK?=
 =?us-ascii?Q?eJlRbCblHCBSpcTOREgzIBLm/vjZQKaQ5il2UPO3EIh9+hkORQaCWrhT2lEg?=
 =?us-ascii?Q?NNVV1De7ys2Jsqp+I3jJK2AKYyLHh07HT4ZxhNz1a+8b/7icXgR+2GWmGf8w?=
 =?us-ascii?Q?5bKqpaY3WbQl8AelHp0TnHK3uTFBNPAPnV0i4ZXYgjvdLrBwh5xEdY/eVUF4?=
 =?us-ascii?Q?RjD07EO/J3GdEuaRnEJEVxYXKfgVJRj32PqMyZKoQDjZn6/EXCg/pg7tjZys?=
 =?us-ascii?Q?9rBnJ5UL5vQ2d2XHzqke+Hd4CqgkMXH1BXlP7baSSBvYBQejCU51Pda3DYVt?=
 =?us-ascii?Q?j/aLe3NAbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1122d4-86bd-4e78-866a-08de9e41e258
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2026 18:31:34.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btFTVWlpRKte3ydjO7wJZuU7B3IZodsee5ZsefNgbOdj3wus70OxbGZmMQ7WkR6BbFTihwaI4SSPAE71UyMiiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694

On Sun, Apr 19, 2026 at 08:12:02AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Sun, Apr 19, 2026 at 07:02:47PM +0200, Andrea Righi wrote:
> > I'm wondering if we should have a teardown function, called before disabling
> > SCX_OPS_TID_TO_TASK and destroying scx_tid_hash, to explicitly remove all the
> > scx_tid_hash entries via rhashtable_remove_fast().
> 
> rhashtable_remove_fast() doesn't clear tid_hash_node.next either - it
> just unlinks from the bucket chain, leaving obj->next at whatever the
> chain successor or nulls-marker put there. So explicit drain wouldn't
> give us a cleaner post-state.
> 
> And the stale pointer is never read. After the static key is disabled,
> scx_post_fork/sched_ext_dead/scx_bpf_tid_to_task all gate on the key and
> skip the hash. On re-enable, rhashtable_init() creates fresh buckets and
> task iteration re-inserts each live task via
> rhashtable_lookup_insert_fast(), which unconditionally does
> 
>     RCU_INIT_POINTER(obj->next, head);
> 
> at include/linux/rhashtable.h:838. Lookups always traverse from
> ht->tbl[hash], never from an embedded node.

Ah, I missed the unconditional re-init, then we should be fine.
Thanks for clarifying it.

-Andrea
