Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC352D839E
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932503; cv=fail; b=f0GLu6Ha7TPitcgpDinbt5wphoc6W+k7JxuCpvt9ch4+G+FClK9igL5vYFLlGhff7QKulpaBejVyDs3Tp45UgoCsfWuSsXCI78+LUPsYbCeP4FETaYLsOEiAV3ahnD2P6TyNdjG36tGWUr6E6ryayD7DqQidrf8pg9mMWo3Zzro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932503; c=relaxed/simple;
	bh=82WaqhACcksjaKABYG6+rNAkBjO4DxWem/Fi/KlSo8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oEmVWavpRzCNvOMWxfBJENVU4tNrq6u/zbdjgZGrG4baRwLXJdEO8tjguEsWJr4k6612jq6kDoE5ybBrwjJOxghcUzWwf66chZBKLdkS8zo4tHVDHUzAZ9hwLRm5HenGgdqt/zbdSH7xBZ6bXsynOHpkW26hRSHE5wKnuIx6fj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iRlxNgju; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iRlxNgju"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUs2eRB/Y9+uHEqT9nHEzYEtqib8l+muVEiaqOw/NS25mWShTRsc82oMMkgqG76gwzSz2Vaz3MxeLb/7fTHYqMot3iLUSJgNXETWva3R24P4fUtNtbe617VH8J/iyc+5+GYVC3ZmVuDdbFj8zECykgzU7K6FzRXQJaja5HDizo2tiIFj3CJpTasbCniIkvqIL0wqqhdUPH+lwIf9n72ZX4d3I1Yeuwq0iy3/ItXjNGO+BaKlpguVueWvTwb3zLJcv2Fw7YoNE6tkEVhl1rhoZXCcNPIYQqR++jI4Tzg2OLdCb3pRaaMYV9hTvw5pZBsdpT/AtG7IALRpSMNMG94yLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hmK5rj8LlzBLphy0lCMjPmF98cL3AdkjTJgmtE4KHM=;
 b=R3tPqCd6d4NuEOR7ADKYmTCairApK96siViH7BS5/K45BVzB39PTwdhS2Q5409n51zHrbS89d9yAdTnqC30hkyYWV/tOmu4OAIkCrG5UMsALja5MdlYJsuAoPWipDNJ5m77tXYNGjztvAFt7A0mtuppReoJDvit88u7EVbyV1suX6vjC0QpMeKpxX2alza0XY8sm/pp6lGLp2sV92P4IDBfZr3+jKeYfFsumQes2RnvPj/k8qRTWTml5+3QXFK0gBxbnCcREhBe07usAV4Ap5vNHYfVjnS8ugoc0NLbMQwDaWf6wBho83d8xmPoFbiaH2OzGeuUQJm4M8fByKpPuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hmK5rj8LlzBLphy0lCMjPmF98cL3AdkjTJgmtE4KHM=;
 b=iRlxNgjuVAIXZ99Mdez/uoe8R7Fwme2dEOH9+tPekqvafbVzbfi+nREARrImOhGjGcDdAH4CqcnibQ+gLpLkUKQpetbrpUGpz6/OjGmaPpT2Zf56qhxABizd4o8D6Zw4PmssoLbKxlNiTMccUMl52vvXDN/GTOKzfT39ShV72pnBECzoR4ATWjqHgInci491ZrXv7dL42BAFrVm8WUvN1ywstBS6QRotCOb46JAxxVk5Ze8gAee3WMZL8TR8vBADWsgDZ2FZFj3pe9Zdn2ZR1lG/C3wOk+ZUwRsSYbdLmiuISQKCmnYTsE0KatNIZ+VLi0ZuAK0Cai9HLgXBRAWYsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 20:48:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 20:48:17 +0000
Date: Wed, 3 Sep 2025 22:48:09 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Use cgroup_lock/unlock()
 to synchronize against cgroup operations
Message-ID: <aLipid4JRKEac1bS@gpd4>
References: <aLeANmpO03QiPgSX@slm.duckdns.org>
 <aLg4SsZHY66n3Vi2@gpd4>
 <aLhvUpkanqxNHyZe@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLhvUpkanqxNHyZe@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb33732-c1a0-4d15-c15f-08ddeb2b35a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56HZRmN+h6nrtbodvRq4RgjCv8huw6qB5VXxuhPmRR+ojeBMya3kK+WFfH6Y?=
 =?us-ascii?Q?rngm3tMF3YUNhggQ9sWdyxMYKKQO8uk4raQ01F/q1HJkr3+VQ857EB5whuWb?=
 =?us-ascii?Q?VnmOw/7uaSMxa9fSEqFQCSw6b5Ozd2G3yPmv+3wdJ41UtWn23Lsd33a/IoO9?=
 =?us-ascii?Q?xbULWntEahzU/5rUveus2+kpDiZWItRqde6XhJ3MKtMS2q4FQi1sF0rbs6Ed?=
 =?us-ascii?Q?DxWSw9otPXrJ5H2JEqwGsjkfZ1AxsDsBj6dRUIh1ChnvTlzzba80hq0NZ0tz?=
 =?us-ascii?Q?YsUAeigCK11CG+Lh8Eb1hjfVyY3jpIJhZ6wkStqaQJJuVsa5JsDuSRdK/QwF?=
 =?us-ascii?Q?8xnwSPpPqp4IekbpgEUwgmgLzSrmqHmc/Wyxplq2gN4LxoqkK4VsdlWS08cA?=
 =?us-ascii?Q?DM+Z8SoXUmYM1jK1GI5CwWApoO4TH69bGxjKGUAy7rc5nynoMfmvOqPdmL01?=
 =?us-ascii?Q?P2vRF4wAngsGls/aEp+u8mX+3MpAt3Z/TECW9UANpsrQCf6ZKsZHf5qbSKbc?=
 =?us-ascii?Q?IarZHdQ68Nk2EY6z2aicoj/QZG/GgEVAD6uRSlwhWdoSfSLjro1xkUzkqXj8?=
 =?us-ascii?Q?M7BOPhoWMk2RSF7mBSb1lodTVJ2Ii0gEK2Udq3XAJT01P2s5kr7kstL0q/rn?=
 =?us-ascii?Q?b3lXsYhg1/jcYMmflAFYL5JsSBzhpl5EIwVqIcKJ+R/lF1FpEg9unil/3mJh?=
 =?us-ascii?Q?Qd++bW4eNxFtwfEsVG3gr0y/O2Ttk9umZt6Q1+WgSbnMpoL8aWpBEDzg8259?=
 =?us-ascii?Q?L6Zit+9HE824EeIrlJ4oaNCTjwfqIk7gwYq69dgTLgbhQ1t+eaTGw1+/QcfX?=
 =?us-ascii?Q?q+P0rl+wSBrKTFZycdQGt8SrqLg2mnXB76ti/7LXHuA/NMYGZPpreyzg/fky?=
 =?us-ascii?Q?SWIpQT5sgqdM0z8Ne2KFnxp2bfcn4cY4lEdG0bL2tlpW35G7kVRGTWVKq3O6?=
 =?us-ascii?Q?nXoaGI/QxNRZS0vmWqBLnrMVGIKrN7acFfHBY4W619yZDauVFPPwppZ4TtAT?=
 =?us-ascii?Q?qn9gQUEHxSV0NezX4dtPGAwjAajKIPr44WZE9kkwtPtNaZYQyxhidRKjxrDI?=
 =?us-ascii?Q?Pf6xjUX/P9sqIpk6ZNpd5VeDUE6e15JKoSdvWGl/33c06MDaSLLXEb+l+KiL?=
 =?us-ascii?Q?P8m/JHbg25BgLy1Mz+8Dtzt6k2DwM5Rw1EBvsi1OmJz1QI7p1rjr/AsTk97v?=
 =?us-ascii?Q?Twzy6fCqRAkkjgGCwXNYvyGQm2lCHnA4wt1TF0jGHnxSKkexyL1tTwjy/91N?=
 =?us-ascii?Q?v50f01mOaOkcPu8+2LRhmHVV+SEby8XhJk9d3j/AmSH8KDC6mH5EjT3WyA9U?=
 =?us-ascii?Q?MFM2485JLSTvK9CLxVMVKZgw47ct8vlVtWI3XqUi5xmQYOE0C9EIcvakejm9?=
 =?us-ascii?Q?5jwY1sZYBqvr3sB2hJvVxkyNvKQ+NgbtnzgIonUZIiiEpyMyfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Fi2UREew4xSi2ui/8fN6qo/RoVrPV+EBO1Vi/tox9fDZMQJOBUY9ELUW2gl?=
 =?us-ascii?Q?R2Zf6fIZr1xntBxZjrYh6vWorL++KmjbuNMElM8xnXmkXNrCUSFmcbCyBvCF?=
 =?us-ascii?Q?mtzieGIYSK7FCf9PKsKunkOdXE86bOvMfb4G+EENOMe+MIiiBWt+W3GLHVB1?=
 =?us-ascii?Q?XZt9wLTRdaDloEsObXmrjv4nBIQqtBPWudvbs2w00HaEi83iksRAI2pO3c/H?=
 =?us-ascii?Q?X2V5nUKEEPwo/MaPE7TBwc911Xye2VBMCxRJ4wmWPSfQ0PvbYCs6gHJRab1n?=
 =?us-ascii?Q?xwTIQsiZx2ppRT18RD8MtUSYeq7sro0YcXLnXo7bs0D0eKwSZ8NlREY8ANZy?=
 =?us-ascii?Q?tJURK7rVw4JEEtPnRPB+I65MnPtvghj5SY7aFR447dGh4ZUinjIA7il7jZvK?=
 =?us-ascii?Q?Ke8zVPdV04jKb58Ixwspr+sei3ln2XjMn+OCvdSJC4icaAFCskpzD+tr+Z5v?=
 =?us-ascii?Q?EZsw8hWeXNG7XQ4f36CHZ+ffoqhFcA1CWsyoWy16QUn3LIjvZJ8kRgUeP8UL?=
 =?us-ascii?Q?5Z6lK88jLp+fQ4VV2DBmFnSPSmMrbPcJte6Na1b5pY6Dftu4iFTQHY4TFfq0?=
 =?us-ascii?Q?3cgrnydFW09CX/uhcg24OJ1lrRznJImYi+UDbPcGzAGuXNfBqlUtM7BuXMML?=
 =?us-ascii?Q?SNksWyfv1CkOAj1RkrKkk9sEyLKy5y2aiiexn49RW5y1D7qXzsX5DyaPjKbS?=
 =?us-ascii?Q?EIqNdIXAUWdS8dVNS2EZ+TwvdzOb6HB8zYUNwsVF14gWqNsZtIE1w20quPbr?=
 =?us-ascii?Q?oQ3ejjFzkRIkZFm3IkRlSLOdMPgdnmBuCCAl8bRrEz06pfyzKE7zfGV4F4DU?=
 =?us-ascii?Q?g4+Hgp4IIKhDG6ynYLYfcJ0iIhc2KSF4vnpZDfkKnggXWG+M5rT4TQr2YGD5?=
 =?us-ascii?Q?7FXqHyKHM4V/U7qWG5hNm6xQJIHzlP4LJn6Cft3w3Xi/8cAHuIFqXX/A70nE?=
 =?us-ascii?Q?4stEopWTSf+uyIskqggnPYE6mBeke/2eWz9MDcM7DvmQzmFydIbaQqNh7x8h?=
 =?us-ascii?Q?rba34Btf7GdU+EzmYl5j/Jro3a/j/ux7UF6zH4dl3SRkBBmKF2uQ5M2wBg29?=
 =?us-ascii?Q?ZbKrAyVodUuWtkeRQABhX3EyYpEQp/GmRkC7TiiDqBlx5Dq4GT6ozsl45x/p?=
 =?us-ascii?Q?TW9xhLnT7dN8f6QofndfuscAi65Iw4DXFMv7Z9MBZcSUfNwFi7n4XdwgqlI4?=
 =?us-ascii?Q?QM4THEhoG6PSaJpx85PEEGsR0K1s1qh7LcALzsHcTbSS5aAtf1ak3TSKE+DK?=
 =?us-ascii?Q?g4plM71qC28i5wb/5HwTdB1SuP/tum1xKoqRnCr8NtrBdBg68CHIk4AysqNu?=
 =?us-ascii?Q?8rZG4ZSIK7i9e8g/GGc/0Go0RZBypj8AM3Lnh4iHYR+GBoDNmGYWQqtuMUnt?=
 =?us-ascii?Q?BW4lxWsJYrORWMbkD0XdGMSyh99XYywyc2vSXXtsnG/yFlz0w/UJf97/xiDr?=
 =?us-ascii?Q?mzZ1io/bdoiutghdkgoXe6BZCZIejIwzfIBHoqqNiDuuRXbFv23uLW48+D0I?=
 =?us-ascii?Q?VxW1vM81V918J/g3US4GoFJAKt79Iixuf93zVEAdPx0Z5hyNlM0PD/jggljT?=
 =?us-ascii?Q?KXmriARUCbgta9V4/mzcVYmuQqkukIismUUj21vb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb33732-c1a0-4d15-c15f-08ddeb2b35a8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:48:17.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrnCLvf2yAMp/Zz+WFb63PSNE6Y/vQkTYTDKO2Je7qaAA0V9MJ91zZDoYbL/pDFaTTa5E6WVxtsoKET7TItWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

On Wed, Sep 03, 2025 at 06:39:46AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 03, 2025 at 02:44:58PM +0200, Andrea Righi wrote:
> > >  static void scx_cgroup_lock(void)
> > >  {
> > > -	percpu_down_write(&scx_cgroup_rwsem);
> > > +	percpu_down_write(&scx_cgroup_ops_rwsem);
> > > +	cgroup_lock();
> > >  }
> > 
> > Shouldn't we acquire cgroup_lock() before scx_cgroup_ops_rwsem to avoid
> > a potential AB-BA deadlock?
> 
> There's no existing ordering between the two locks, so any order should be
> safe. The reason why I put it in this particular order is because any
> cgroup_lock() holder has no reason to grab ops_rwsem now or in the future
> while the opposite direction is still unlikely but theoretically more
> possible.

Isn't scx_group_set_weight() called with cgroup_mutex held? In this case
the order is cgroup_lock() -> scx_cgroup_ops_rwsem, or am I missing
something?

Thanks,
-Andrea
