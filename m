Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC040E8D8
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830343; cv=fail; b=XcyIrQsGNhdM/dcy+cVwj8+GNV5jBRmJFvAYB+xftmfzGhYwUGSIGbBRlcbGE2bA1i5rOJQPhE32Dk/8kkL6njeehAssOjk7ecdE5N/bTlx8cGw6xgc1rG4wfSCaAnSw5epBMhNxSWEt/bPrGinqVQwBBakFZgk6YXEwf2DEJhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830343; c=relaxed/simple;
	bh=mP5vWMQaZ2EuOsoqFhUBn3T7UAcENYhksbQr8LDzWsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MaTOc9Q9dHWw6sq6BpHMKXGZrzPyNh4MN3UQ8N8lC1z3UmO415lefAxK2b8bk0HTDeozs6X3hSYkPb1dsVz0tLgPAHtjq4erGluYnRlxzhSF6/U3qgOvvazM5pKEOytcgMGhXzzD+af29aX5VZsq2F+HvEoFTz7k31qon+8css8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=elK6K81Q; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="elK6K81Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubC3DIAYvKH/ePznhfhtvc+Kuz3Tg+whTNdFLoWwxt0XeMYJN7KWlq3UD2z/oMLHOck3BXRSWX87R6JHNyk7DZk3NH5b7NHm194MTvn8v43LmEjdmgTgxbUGtRIHD5sxPAe1i5xFVggs40iHsfGI846iD13A/Rz8PbkOMGa8pNDKlih/mFjAE1ZCx+2m4F1/aCx7TyjQDkI2ztsp8idreDagg5/mL8y5e3zyrcUzUJatWub7ZKy9BEF5dugAJdjFwAbTa3v6x70/o5gUN7LEdupo7JUnN/0Lh3oAJphiMv+vkumCdXDe9yHIc4mD89o5UosijX6EyQJtqBj+XJoHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amIXZ2eAgI+Q6c8J5ymSwYWo/36jTYs9MlC8/DLRYk0=;
 b=nbjuZWfF+1Zkm1wa320SY0iBfHGU9oG7iutBjFbULYLoRJmFi7GbFPKYXevzWfmVMSwWGi1zccJHaErX7sgkUHL5msZi5trTnd+3+DHpRu7C4DSMHSrlmoOMgkEuqMtcbAXZH0UTd080nkrdF3131ucndmV3yCCGFEr8sEeZ1w8ac4SGSQKyctFns0I2362CFRBLcLjj+WkGbGnm4dykC//RxCf3hxxE6P9pTm1Wy2m7AgZ81caPvt0Q4C3cANjPyg0A/neCunVmWrAE5GxEO/Hby59waI3qf9CCFdxfoNyIm+ty1KFLRSsGEMt8ySitelkmLm3E6FX/ICKYifLRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amIXZ2eAgI+Q6c8J5ymSwYWo/36jTYs9MlC8/DLRYk0=;
 b=elK6K81QGlirpntg8KNiS+P6lIDy/Cch2JfpqB7RbjOxD/SAt8U09HWP+1WCU1cCbfHitVP/3regDAdHLiTQjE9vJwHmx1WcJLqbTS6RvjdNTQEcziKcv674WjtjSYXsZUsS0zCu1adFRzU/v1mudIU/U0+w/eBFQAmj97uOr0638HolTKVC9Lpd5udWbFcW8R7ATdTrhlYV1OJIurhKqE7t7ioINUfU6jbP0DM10GkNZnVjoQqNICw+GI/FZCIK9dkw70v1UBfna9Y5iXEXSCC0KsCCudMApSECPnnY8KTF6fRRLWnLaYq1uD35Kx1y7/tDmB5lvFPvurJKSLEJuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 14:38:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 14:38:58 +0000
Date: Tue, 30 Jun 2026 16:38:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH v2 sched_ext/for-7.3] sched_ext: Replace open-coded event
 lists with SCX_EVENTS_LIST
Message-ID: <akPU-sWYzr7momty@gpd4>
References: <20260630140645.8855-1-yphbchou0911@gmail.com>
 <akPSxgP6LKir2OrX@gpd4>
 <20260630223257.G4ee4@cchengyang.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630223257.G4ee4@cchengyang.duckdns.org>
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b75c4e-2394-4dab-8cca-08ded6b551cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|4143699003|18002099003|3023799007|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	1qBzS6Z/UvNhUPCDPRTCpXXQ3OLN6vLLZVEGLW3EsIBBRsBXRIMmX36m35LWF6caOznv+tjtdH0jKJ2sz5yb+Qi7dgLHV9IKBORdbLkC9l3XrHu+1jL+LMst/+ztLPLXVQfhyNft4bbo7yU+X3gIMhB9SSgBVXtPDznZowr9Q5UVEFPZMJJvRag/Esf87I153pKMC6YewNHHbB6bl1ab0ccvRrjfRqjUbRV/BkPI6J1sjSztcX5jFiKy+qHw9o+46tAomIrj/dh9qIbStYmGOIejTZp6YsCgup+Q1izns15jTuwnIA5UVCuPLEsG4CkzDntOisZkVLYFRde2z5ubDcj+Ey74HmUvraPhUtpkQi7leC8AqanIWXAxVxhP29TFiRMdFdjNqKRF5VzFh4LDdZpsA/WtkZqdp5q/FmpajZr7vjba7ODJ1snTIYtj6MLwhcmaiWf58E/vKUGI0LQX4bRd4Z9/QJyIgWtoHhw0kaxtLHYXa9JodKn03P0131OBU5dYavJG/KmEhuMldMPzX/NVfvJHqnGqtGbqBa9IeJJ0xGunz7KyEb+HotA1kuc6XWz+bgYV+MuiPc1NrgrkWbOrEN8pdTXRQS0i9VBonugLavRyXMDTBvJJDpTNu5zahagQFGjo1Ugb2iDNsso3hpAcapIw10FNbDHNhRALTJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(4143699003)(18002099003)(3023799007)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j9zkABKC/VA2hm8a46qwvLXokRMmvlKkDlu5G7CGnZfXvnBd5mKBSHCHuZ4j?=
 =?us-ascii?Q?kEK+7kToBkfKBZgO2dKHRIUJt720qXd+nZqdux9RFXiI4ywciNOX956Ok/bD?=
 =?us-ascii?Q?T1NlnDWMw7N2nnXGAPKVcguUjB9zUlMADK5Pk0/JrkUqEzYNSV+c54jwVH5/?=
 =?us-ascii?Q?+kQ0J9IigSohQJvVWkLrOzfFDGsPO2B2abI3XFncAi9UEkeEnpB/78eUo7VF?=
 =?us-ascii?Q?E9ki4l+9oo7XWFvyei5m03uJxjqjptSQpvjWiHITXQSuF6cmelthuHwQrELW?=
 =?us-ascii?Q?rRWwPbUj30ehHEmS528x6Dl+5iz7+zBcG2AxSudxVVtFHF1Eb6mMZxbKZMEr?=
 =?us-ascii?Q?f7nS0O8NgHn8Mf9s1ILnFq+1dQO0Bk/266VbPY9C3pXhkU3nPo7Shx+PINx9?=
 =?us-ascii?Q?GlRViq+hXoD+2sGMZOCd85adEqYLmqLs7zwtYXnkmFenInB/iwvGqQliE652?=
 =?us-ascii?Q?XRwDO8+RrCKr0NhGy6yuIyZpqFbnW3ZENZJ0XoUAJzPp4w8yQkrTSo2E1hAb?=
 =?us-ascii?Q?B6RikpZBRj5aDoAfNXZjMTynKmqny+Y4v4awtjDpGI4tLE1homwf9YmIuzcA?=
 =?us-ascii?Q?yNVvll/18aR7j9l500Z2ziKZ+SawtTBPzhWcsoaNEsK/iLbIICMcaaBQZYi+?=
 =?us-ascii?Q?Z8mJQ0SHwlPmiE5E3fLl1NNm0Jzyr0F11yYWn2yzMl3UHHUUG72FJpOIQnKh?=
 =?us-ascii?Q?nDkJHi8C4y6GEp8grIDBhREiwzF28XvjJGlbRNbWZUMsjvSLnQPp+xnAZrFD?=
 =?us-ascii?Q?ZSvlkz1tvk3gZ1yQF9lXL6CYU+Qc5HFK45sGrC0FF5KpSxB4PHV0nbXBY2U7?=
 =?us-ascii?Q?OKbTzjVnB5Zn1bgN+1OJS5v3vpeQF/hfqYZ1VTecF/c0WaUO9ikdeyCxRIOH?=
 =?us-ascii?Q?j3QjjucSBkqsgBn6TjBvBNIfdBjMmcIw66u+n1v+wYGsV9YKAXRxQnvBJWf4?=
 =?us-ascii?Q?YZTUTLA+lDSzFGacNhUgCSzYQ36mhNvvgU4/JaT6vx0s5Op0BSNM/RWbYJ+4?=
 =?us-ascii?Q?Kf41NrEG9E3WbMGCTUsmWSKEdYazz6Dof76rjUMugqCKguUvjTvQX8te54BG?=
 =?us-ascii?Q?zUkvDEGqCFP0hLEBY2ddE38Z9Vn0JdiM6GZ3ADXcO506wML+Zu7yl45qTJrX?=
 =?us-ascii?Q?gKBULeBUs2HeVeyiFtIpHXYXgVNctDlV+XGiKBL37ABo+RmSBZyoCK/U7yJ7?=
 =?us-ascii?Q?a1HwPEACujYf3IiDr6FPwxXt6cF9h7MWNujAs1U4wGAHhAFyghDHB8CTlrx7?=
 =?us-ascii?Q?a72jw93+l0yQrcRkJf3naPAsFDVtcNb8uIEx8fpgKpn9Uko3N+Kdd2ddVvJH?=
 =?us-ascii?Q?PJyI1H4VBhhhoTIlKj2ojtMDB+4lI/84z4ZwZpjkAGWm/1sM4uWQ+v3SLIh0?=
 =?us-ascii?Q?cwa+Bey2IuwjD+OP/+hQBUf2lTD1S8OMVntU1VOyXaHaKegDrS1OiP5UfjE4?=
 =?us-ascii?Q?ISXDSwA6fdmZVhyYBHaADz/f6Vf3M2OQ+3WyNnviMQ500i07YGJUs6aD2CPR?=
 =?us-ascii?Q?8zr/RrZZFIabyKcj3lMOFzbdGxEuVxvXcDdAYL1WEYaoiOX40pubsCOJwwcd?=
 =?us-ascii?Q?RRgRb2H4jCL0l7Oooaud2FqR0oLGkIOSzVh1++XWuMlx3TZZC+hc+tmOAXwi?=
 =?us-ascii?Q?6sca6+enAscPFpQdkdWx04Chrg1XquH4uCqOZIzh14Q47Tv4lCbFMDhvDtOX?=
 =?us-ascii?Q?TI8N8Wmypd/NwdVBIH+8BDlmj3ew5hn6GRbBPNhFxCQzcy6UOXHBczQynbZI?=
 =?us-ascii?Q?6Y45+Ik9oA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b75c4e-2394-4dab-8cca-08ded6b551cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 14:38:58.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8rdtHMmQvZq7KdVUiZ+zEVyajKybgAAgIb4AOJcZHdc5L7duVtdwIa1a5hnSYappWTHYd4u6f7p8T87amzkSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654

On Tue, Jun 30, 2026 at 10:35:08PM +0800, Cheng-Yang Chou wrote:
> Hi Andrea,
> 
> On Tue, Jun 30, 2026 at 04:29:26PM +0200, Andrea Righi wrote:
> > Hi Cheng-Yang,
> > 
> > On Tue, Jun 30, 2026 at 10:06:23PM +0800, Cheng-Yang Chou wrote:
> > > Three sites enumerate every scx_event_stats field by name:
> > > scx_read_events(), scx_attr_events_show(), and scx_dump_state().
> > > Adding a new SCX_EV_* event requires three separate manual edits.
> > > Missing any one silently drops counts or omits the field from
> > > diagnostic output with no compile-time indication.
> > > 
> > > SCX_EVENTS_LIST(SCX_EVENT) in internal.h becomes the single
> > > authoritative list of event names, so all three sites stay in sync.
> > > 
> > > No functional changes.
> > > 
> > > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> > 
> > checkpatch.pl is complaining a bit:
> > 
> > ERROR: Macros with complex values should be enclosed in parentheses
> > #62: FILE: kernel/sched/ext/ext.c:4964:
> > +#define SCX_EVENT(name)	at += scx_attr_event_show(buf, at, &events, name)
> > ...
> > ERROR: Macros with complex values should be enclosed in parentheses
> > #116: FILE: kernel/sched/ext/ext.c:10267:
> > +#define SCX_EVENT(name)	events->name += READ_ONCE(e_cpu->name)
> > 
> > Not critical, but maybe it should be nice to clean this up.
> 
> Ah, thanks, I'll clean this up.

Maybe you can send a follow-up patch, I just noticed Tejun has already applied
this.

Thanks,
-Andrea
