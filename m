Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB333F5AA
	for <sched-ext@lists.linux.dev>; Tue,  3 Mar 2026 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552350; cv=fail; b=hFcjraUVZrImJ0+WxCZoq/mqlhhh/aCX7RQvRuhSoHGbBqs7laDSnyBbiSKps0gYQ2AvJRICGg1XLwM/Rs19tjIeUpncunHjfzBLSZ3Iofx8r3DTsl0OgHA4S384kCkPHjCrW6K0qjyeGvF3Rvx4TqUGgTMwb2WkEktjbANsDLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552350; c=relaxed/simple;
	bh=qeJUbecCQ60tu4rzVicjnYvWKX9bpiMni6+fPw55EYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=suY4hELpZZJRy938RZNIqFaPlwam25TcAiojcN12JUpFpACsnOTWcjQ2kyi2HeX2sGqTeeAZf15JwUX7nbDiO8e3Htr9pAufbWYPy+AfKBzBHMWHhGJ1wsrP88LJ8XMOM4StTJKklT4wfifGSE7ARPRbcMVVtncBbqQZoU3Onc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FeMOd3Z2; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FeMOd3Z2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+ZRXxnx5eRN/aE8A2Z6xTHLxf8o5GJp1tEJNjTfV7ZNZ/yzEFQ3ufq6mXjSgV5w9ATCCFVXCc99eno5Ls2rjlHJtPVW35h8HdHEZzVktQNcwzjeNXKfiDoWxZ/g597jxOcruaCj+tA3vU/nw/jqxUF4LF8n0089VFbTZmxRJAi4LoK/CY3FzZ1W1DfJtHmQTAhm52G1J/2mXezAsK3SgkWIN+R+2zMMA7cHoSiblvi7Xd8wGDhu1GonRri5tsu9ITj+XOl3WJegUonWatrcGXAo6lPrsmXKVJUtj5j6GKKaA5SC3FJdHwiCsKwEGNodi/FJSJkda4bSHVoHMBHUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF2DARQShqPlouDQM5icplNdEaaSyqs4fdxF2NEPkfY=;
 b=Tzf0RXCszrU5aNNSWhlXa4wW7HylBWsV8PuK2caZgmUFj7Bx7b7XRFLcBuseBdspOg3wBs/N3fkGnemlqYCi9jLC/eOv//y/TZx+BUXPoQzIStp1JJnm3jb6WwHoiNG8st933ZWkJPioaD9SV/ljAEx37lYVgarYlc5OAezBFYGVG/ADFQgbwDzquzq63qMHxKwhy1jJhIMWlLPc3g3IoU1nPQRIfmD6fPP0LXncp/zIElMT507TuFbOMedFaaFxziXhUNHUlG/yUJvVmSMTKI1lryvp3UHcYmKWZHfrkUZX/pE1bkUZ1QLlNgcWMJ0NwsKo4kiWrDmAKHuspSI0Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF2DARQShqPlouDQM5icplNdEaaSyqs4fdxF2NEPkfY=;
 b=FeMOd3Z25SGpwYgo6DLC4xNcSkVOpHdYiulfjD9/UfRKANPMXNuDDIqVvk4xDet4UKPaW4FExRqOXeSXm5lT4Du62J5G26eoPTCbq25RucfwXLXU5PCq4Y4bjfrxoVsQ1rTZR9NfHimO+mJOnO9TehyYEr0xGL4WKmmqrgLN8P/t+meavLjjDNNXrRVu36Ym3mr75a0P65F13THhhQ+vfwW3b9HYFiJq8KrCU44Ti9GMe5GsPQABX9y/6p9oLq4LmkWEg+TA+pOsTen/GbBDCIzvW8/9SWq1i6C/46c/JvGGfSRn+PRyFIZd0k0KyTsf9uHJGWhVff3citY+IVgGwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:39:03 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:39:03 +0000
Date: Tue, 3 Mar 2026 16:38:54 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 1/1] sched/ext: Remove redundant css_put()
Message-ID: <aacAjqWhjhQrLeHn@gpd4>
References: <20260303143530.135968-1-yphbchou0911@gmail.com>
 <20260303143530.135968-2-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303143530.135968-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 35af8837-4401-4b68-98cb-08de793aff6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	CDdP8pGn7dL3oi1YpEoSfl6nKg8dSW6Oyr4bQ/C8AzpLeqArVb2esWWu52S8fAI1gvGjOKT1rhmbhydj/mdpYOE/Lfte/KuILFly3+N0Qy3FYb4Sd+IcoysmS4yZKvFexX75r2H3Xi6xpjTBVSPyF8Rvt/VyWbIXU20v5nzzOiR4AtMUcrZa+Y5CWZBSt46inpREZrkcmI4n++EYZkADshO0GeGLIjBTYdoYX6j7UMgLmIrmqn5Enti/+HtQm0b//rfp7HoghJhWKoAuFLygYlgs7YkgYcyMRNU56TY9pz1wBeyUnkC4uqzjXnt+TVLD4XLZObyUwO70UHuFajUb7Y1fzzAfS5SPV7dxyWNdOp7EsNej9FF4Ll5fU26haqMU5LAMPWsSeQLHO2DQpTT8NfsKxw3k+t2rsNSBgQ8l/O4ilL8DpglIQW4gsi/WkD2YoiJbGCkfhxQ0AT9HkdJGPUooO+1Mp9uumeMkyuhXdSq87ysKO+r2i+gVI1XuyCC/YJulltCmcP8UGMLObrIuppSiH+I9m/dkdgxE7d8quKSqqmFt1PXPsyMTLG5DqW0OQE2TNOJ3XcdaQzKgBdCeOuD4yVVsSttYamt8eIOzZtijAWG4nhrjmUHGxV2dJDq66E5c1AQt/YwxSgr+t0Pay/QsZQ+PNJS4zcMlMw4P0wUHoWgQPWfKC7eUf/XvXVEWiVivu7dR0XBqt6aX0O3H+yz9WiDfuhwtmIaWX/xU7WU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhreKNjdID1hRzqFD/3k2k9ONNZzE1hU1CGz32c0gbenQXU8SF5mEppcom0j?=
 =?us-ascii?Q?mouRLNQxE8rgrCAJa80KkNvGsVs6QNEVRZzDNMfz+r20gPB3R8ALg9Xd/a5p?=
 =?us-ascii?Q?JKtV446AAmxVxUT4ccnWdXFiZCr7LEVupzJtSJ4ampVqOYtaY4HHvOyLFCNW?=
 =?us-ascii?Q?tcueNOHlBxBFzK0KerNL2YYDZTS0PwafZu0/N53NQSLHrVYpDoZkldvENayQ?=
 =?us-ascii?Q?rrUpgS9xUit06QQap6gr9eebRUCDK2bvi2E3EpEy2ulf/a3W/8FoDOxV+RJW?=
 =?us-ascii?Q?mCcX8s71FJuzXBzwYoLwZ3+c6wckFBjmp/T+RfZ3coE02RpZd4VSyT0WiM3S?=
 =?us-ascii?Q?Erp+84JMvbCOTn3+GRfiSGqz5NcpVpSrY/nw45WWCBf5PYOsIGv/5uTwvpvW?=
 =?us-ascii?Q?ROg9G80Xk+zPkkGAbm8dou5F5UrnWhPoZkEnlDJ3vRAlk25+AASKFeOY1kXI?=
 =?us-ascii?Q?kuPb7OsuUBrA11tHpyReFUHEE+dEnRA1Rxeprs45iaLTYAfpkpju1HtEd1In?=
 =?us-ascii?Q?6sF/k5Nhuo27miDCUtlxe7ibiGznfSo2g4P8UNFL/eF+sBk/bDXW+dLObjxZ?=
 =?us-ascii?Q?roGyVuQKtRuUzj3+HxXVW5yiFEg36Z7w7Yj72+QvdvAbeyjSDRSWIH6h5xva?=
 =?us-ascii?Q?OZ3iO70WRx6B4zhYcGqH7zKsKUQ1O52bRQWn10l+yc+lItLlu27zwXG7ZMTn?=
 =?us-ascii?Q?OXgFDJHGe1k487VHdKSJwyf95r475uZbOXoSd85w4wg03XFpqYcT9diMPftg?=
 =?us-ascii?Q?8wAh1O32YZvJrHKfI/7+lEvchelKmoobjZ1/HPf/M9r74a1S5YdyOJLe+X8X?=
 =?us-ascii?Q?G9QlWu6jAjsMJujofln/sE6CKicXtYBdZKY6FuQOvM9iQaEMgAzWUzm5S9nU?=
 =?us-ascii?Q?TipRzlZzuyfPT3lawzgUOFzGHJXAKfzLJj7TjnSIf7LpkqSrw1t26vfF30yN?=
 =?us-ascii?Q?X7fxYugKRslOm/1tl0/UD5qMyK7WB05yzIC/k+QeLFavCTpC+0MGZPXoudUP?=
 =?us-ascii?Q?C2n6FJJCkTt0qVMPXB5kanoAMQTssFbl4j3c7wk1pNU4J/1O+dfkJUgablKE?=
 =?us-ascii?Q?BRJwIE92c22GaBI+ktTUGuN8yLd5wUehBT30e5BOzFplP2ZwjAO+l+Gnc7kR?=
 =?us-ascii?Q?SWiZwBUjj9HroVYDv5livwbiL2YDXPRAsLuJ2l3xZMj+yQYeeA+aUNxlgPVo?=
 =?us-ascii?Q?xaa2dj/+XsDOusnvK/MkbDIXcUg9OhI4G0R1lnW92I1l27bBMmymdmybuE8j?=
 =?us-ascii?Q?kF0R9F6KNOjqg5J+6FjcDTARFE+Uix3FNz1wtm2FMINP/pZUyRD7zxrPWX1P?=
 =?us-ascii?Q?7Z/FKl3SNWd0v8cWULyVYKIwiBzNv3RhjsqHOx/Rz1D2uYMtNvmGtdRDDFuc?=
 =?us-ascii?Q?aSVPvKi1NKkzI5JX1zaihno+IuW3FHuGeqBRDZMn4jLwcUNUYrKHO7eZSdLW?=
 =?us-ascii?Q?QauGH76k7wx4F/cF207SKf3pWDmrSNWeWus88wqPESQoLq/zYUlW8aSfth2d?=
 =?us-ascii?Q?xFXCxPfliuxhWW7UtRAUaqnhCIke8WGPi84jB8nZ5ycug43cdAmpV9Okbgm3?=
 =?us-ascii?Q?8i1UESJyVFKr6aVPHjnWo/CmEIrOdcKIHWZkBkduZjoeG3kIReu9QZUkd1On?=
 =?us-ascii?Q?mlqmGPPpSyVhywrQAH4ZrEEDUyZJYj/j+2xNmKMbAVFsSHmDiinDnWNGd1XR?=
 =?us-ascii?Q?jdaDslnDMe6POPGy8UFJ0xaB6wcVKAMSXCRcKc0uXzGwUpH3yf01u1EElouG?=
 =?us-ascii?Q?+71z7/7kIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35af8837-4401-4b68-98cb-08de793aff6d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:39:03.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EW2b1lNxla4oBufSvB+Opk06uDNVvQoz54i6iwu7/3ERR1hvu5VoNbMbRhUmRyOumKgLqZsjayHk9qu0CFZEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

On Tue, Mar 03, 2026 at 10:35:30PM +0800, Cheng-Yang Chou wrote:
> The iterator css_for_each_descendant_pre() walks the cgroup hierarchy
> under cgroup_lock(). It does not increment the reference counts on
> yielded css structs.
> 
> According to the cgroup documentation, css_put() should only be used
> to release a reference obtained via css_get() or css_tryget_online().
> Since the iterator does not use either of these to acquire a reference,
> calling css_put() in the error path of scx_cgroup_init() causes a
> refcount underflow.
> 
> Remove the unbalanced css_put() to prevent a potential Use-After-Free
> (UAF) vulnerability.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Looks like a valid fix to me, we're holding cgroup_lock(), so we don't need
css_get() and this css_put() should be removed.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2ba69b302368..eab6e09b6442 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3589,7 +3589,6 @@ static int scx_cgroup_init(struct scx_sched *sch)
>  		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, cgroup_init, NULL,
>  				      css->cgroup, &args);
>  		if (ret) {
> -			css_put(css);
>  			scx_error(sch, "ops.cgroup_init() failed (%d)", ret);
>  			return ret;
>  		}
> -- 
> 2.48.1
> 
