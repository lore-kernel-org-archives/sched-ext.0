Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D638E110
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126618; cv=fail; b=X4FEZyrPhjzgluaf6RK7kIAIRg+foqfrGioTl9yZ7eDG2el/p2mqpQOz3IhHuu4QwwvIo5PJ3MTVyyzK7uvzig/79kUXyeGnRLSBdoNv8khDRc109AXMnxSqX3TLoalcDqSdn0JMslBa4RVuLndpsZNKQrV1y+7UvmvtctykZCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126618; c=relaxed/simple;
	bh=COAC8/Xy56kbeCUybeNizcLJ0Ajx7I/ATP/CwMyqIz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qs9RxHekz9qV+mwFnhvittK4Du5X8cN07TZOg3/aL74VR+SprDh/+iTFC9nNbj0LZZRix0pgsxz2LWQ3dAt6xaq73J0FPpsExTeM73ohvXJfkJAS/KwVrAxG1H7PYF0cTU/JE9iFkHQd7LdADRLL5wCTddLuS6wGGXITuM4o6Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DuT2PPo1; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DuT2PPo1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKJ9rb9eMgWrAgRtsfJxxawP6k4+FuKDa4pVO+cRBCNIQK1SM6802mj6hY3vmbr7WeD191Kl2Dx1hR8TTImyYjx+M/ARtFkFucyRWLdmSjunCjk2D/xBnRglO3RYBc8oGrEBRH/U+vtLHN/K1hwuYHPKEYNjs3Bo/QqnNA2pakuGmHYAlorA2+OeMZkEqqF4AysIb0VXpk4f9j4vrihK7EoLytTUQPqv4qLeM6n64V+SzFoIcnWl6LXWaiC4zwm37hffLf1O5OvNA+ZdaBbDvdximtkQNWW/h0gtN9BaGCH3nl9aJL1Zk4Td96OpUeU3AAkSjgTUaUM/1Nx1ojg6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikZNOh0LAD9unSFhT3jRXRdDHYUoTf3NzUMmL8hSVxk=;
 b=Hpb2Mty3kHxWvZCUZGz0qnMpygACqK9js11FlPYs8Q6yBcQTGRW7gw5DBxIaSTwi3v4yTXdhO6Ec1k3sYCKMlRoYIWwXUYgawpwGTbN+ICbA593+IGjy8RGpDJYOEH2D5aDw4pcglXlVPro0lSxK7FE9Mkxwyfrhl1tIjDzgAmk7qox5gSoDwy6njZUdwMA5h0+DMVg+u571hAZuDcRd9qvGy+OQ24mZmdi+vo9ImhJPcWx3uP9pGDe6klfqVNomjqBvI+zpu9M2aHiynd4PuARPgk/+WXMcP82TjbTH35JaMgS/1xnoVVVRCpq/d8LEFb8aBzBIJgelUKqOSUeW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikZNOh0LAD9unSFhT3jRXRdDHYUoTf3NzUMmL8hSVxk=;
 b=DuT2PPo1iaMon+LLyAOunGqdh01VhfLtXi7R+3eLKuOL4mLYLEKn50N2cBp1LMGB2Cnm4d0YyeTu31WX7iMS59z8x6DGKE280h9aeTDXASjxPGzhAHBIqerHP1P6399k11J6xybkXBzn2Y2Yj1+ThW5jWV3PK9qa/iYz/WkmD3nFnRJmUSJWZafQHYqSQXoczJJTBw9ncByhkZoASGukdMuJjPNoFCLK5KHj6pkjP7VxBzs48H9pSH15INvYQMMY20OzQ/KxgJUdcfM/37zPCZwwMP7NB5otBS1PhN/voVaPlRMTZfuVAcotOunWV6BPAEE8QZsWjJncMF+xpqneiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:50:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 13:50:09 +0000
Date: Tue, 3 Feb 2026 14:50:06 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aYH9Ds0yy6cRxuZI@gpd4>
References: <20260126100050.3854740-1-arighi@nvidia.com>
 <20260126100050.3854740-4-arighi@nvidia.com>
 <20260202211326.GN1395266@noisy.programming.kicks-ass.net>
 <20260202211723.GF1395416@noisy.programming.kicks-ass.net>
 <aYEnK57vUwtgGXwH@gpd4>
 <20260203103407.GK1282955@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203103407.GK1282955@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0ebdb8-6279-4c67-d0c0-08de632b2523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?npj9IWQ84SO+v7+ynjjdM3IXQUWtTgcJ1vbjDGltMW/PIF1b69vg5gHpp4jt?=
 =?us-ascii?Q?pvRrTaAxyN+/x/f6zHKUF7dVLNC1U11P/7p10Y0vJU7v8JZTZllsZzCKjWdo?=
 =?us-ascii?Q?PebJYZOvEU/J0/pF22WpZceXo1l6MKOfO6Kb7igipJPRe57oH8/pN7LVFUCS?=
 =?us-ascii?Q?ri+/2CCVrVv+va4VbczwlaUZYky2gv2RXz8DjGwyDZYvsvkBbXhgH3tB7AC4?=
 =?us-ascii?Q?ip+2tt0uk295NDQvTeXuxbsdcFFnQveNQH58BO1E1PregJxT6+ADXPb5irpx?=
 =?us-ascii?Q?L9Z00e2U6N5hEtJkZvthNagEruF+D2Tv98c2aA2omrH24ftq++50gR6Z4KMu?=
 =?us-ascii?Q?XgTr7OMKmbmn3KfNRven3sqg0ZWzU2TdFzWvk9Iw9OBj/ALAvIj1PAIJEPuQ?=
 =?us-ascii?Q?vFDvRqVJBryuCyT3ur32TEF3tdUsCzl6I+49uZiO6vAKBSEmuHeqkZcY8k3y?=
 =?us-ascii?Q?miLKxKp2mVCMRuO767RPgl+bXeAG0iEAMpHdbkUcsO7eVqvBE7Z9mTeHno6H?=
 =?us-ascii?Q?6G37fcaE/eI2DEcPspk+/rOAS/Yw9sB4uF9/xxrMy7leEXiTPXxNR2lU/YVq?=
 =?us-ascii?Q?a7aRIsHpOi/F7KDhXZZwU8G5lSoMx/ZKL4v0CXKwkh64apIpFu0BNjwd8Yup?=
 =?us-ascii?Q?4DYNPm+8jd75NS8DsNZlC0n2enMaH3ap+ckdEEQ3mgdBp62DGmAAsGBPUHdE?=
 =?us-ascii?Q?QKKB+z8JPEc081hIf4kbXoOhJRlD2WLgxxkovGXPPSnLL4y29pceTGt9gNRc?=
 =?us-ascii?Q?ihrXDnT+sIM5FEgkhtAGdFL9fCtdnis+AzB5we2Tiib7T2CVGhiQxfUnFkBj?=
 =?us-ascii?Q?HFT7UrPNy1tWlVkEnFoVGTJzRVMoVGqMjknbryidMRmRQviB0GBsKmNJQKRT?=
 =?us-ascii?Q?xHcles66MIaInDzaOeBuFotx4DY0JSuLuTN89nVwRwyu2dG60TfzT0faTKc6?=
 =?us-ascii?Q?lhavsQ5crI87q3JzpoJCzWVl9J/sBdVgaJc1dFlw0qS2wwH0GFoChp3d0G/E?=
 =?us-ascii?Q?RWnqf3o8dmCrA3yc+vNax3Pn6Bt7Z0rjK+TYQFqMDEShCHeBrs2vPOZAE3S0?=
 =?us-ascii?Q?2YXIoABb+x7Bc+RWp4iFb1Vo3/pwas71DFnn0pom+fYMGYtNkbWedIv07J+O?=
 =?us-ascii?Q?Leo+fcDpTVwG7QqRXA7NIHcCvR2rBnz6MFVVvPs6yNeQzYgmzgB8AXUI+3/2?=
 =?us-ascii?Q?F8QLA8dH3GO2mkAbJ8cI/h2eVB7QjpA/PtHA9UNtqh2kcCyYYom3epe+wLQ7?=
 =?us-ascii?Q?hOGawk2GqrIVVfoE2CY245KS/wp2C+Jn6w66uCQqoKwGRGwaSvOgHz3F06Vz?=
 =?us-ascii?Q?3HKMtfPRntOYLCdFdfuaW6Nfh9dtOtgSLRIT0CEXy3Q/ifRBJ9V9A7Uqju5a?=
 =?us-ascii?Q?u2i+TgiclspbZkRbezEXpz6HZ43pvUyrzmEL05wiBGkdjfv72fVDQZn2XcUL?=
 =?us-ascii?Q?j5L3Lo7PqLiB0IVKiLO4dv9T456RVQsAcK+NCCJ8krLecF+HiHj0vrknq3lp?=
 =?us-ascii?Q?M1BaV491VpoTRxYAuvX5rqAtqxioPXYxUkHViiLk22I2AY4+4AGLo9lKNEx/?=
 =?us-ascii?Q?BAi/LTW7LYvOl5hSD1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uudaQX/fO5Cy7QWv+FIzrLeI+Hu0Z/dw4g3Ck7DM4QsdM9V4qT+73RW6ORHk?=
 =?us-ascii?Q?YhKjAPxIOEedTT9iJG9XXGkgasLqa4KBE65rR3TqUTC8F7p+xI+jAWKqtC1v?=
 =?us-ascii?Q?76FbgNNMwwHRugIqTN7aLfxj+erAwTDYjXVErzMErvBn1wMP33KfdEMg4AmA?=
 =?us-ascii?Q?OEx3nIWlh8a44fOqeDDtxetnu0NmeDHpI4nnp0FxSnLkpAXnR89mZy1M3yvr?=
 =?us-ascii?Q?i4YnOfBOrMlweTZzDh/aN681sw9zgnc6/BToTp4bZDPl1APLUHFjEbrNgGDm?=
 =?us-ascii?Q?In/nwKWz0PjuQYCnmOCWWlJdTamsq+j76BaOPj+gGPiO+XnosdqkCtiIkQ5U?=
 =?us-ascii?Q?szQU8YRnWShRNFsF9gZSrpIUJTYhgcieTbUBtDH1G8D68qqJm7xWej5C6GFN?=
 =?us-ascii?Q?AgfB2CRa233G+A80NkgvMf5VQ8qpv2uXQd+YbYtJ1E4gkkjWz7Howcr0RjOY?=
 =?us-ascii?Q?qjxYmXFdHpuRk0Qex95QjxvAeBggO4CkW64nW61GRZ3JEKPJ/jnFg1k49qRu?=
 =?us-ascii?Q?2R2ANuEqub0JKMXUtd6S32wIL0dagxuPOcNet/PCfE3X/zJIYGJ78iJ08GCz?=
 =?us-ascii?Q?Escg2ZCp6wwCGf48iKCVEcefaLo8CxZ63TJ7ZjSUUyiTb8g4dhkjIuzutgKb?=
 =?us-ascii?Q?h0Mwzy3MWw+7hvevczorI+QvrwH8dgpzt5VaR4LeRt1FBUQX3uBmqjGU+iDa?=
 =?us-ascii?Q?jyfFwteab0G1Or2lk5MAjNqc0FqUvi8hTbiQ47nsbQyUY3ngoiDOcxsYRFr3?=
 =?us-ascii?Q?oBSzf3kZSsl5VyBwmu4pLau0jPnJ6YSjV3XLwt28Nxs8I6cwASN+BCoMTA3N?=
 =?us-ascii?Q?YBpp6FQe+pEx1hNP5Rpip1kJ4FPJ/UVfUDf6d8t+RMLd9s8Ak2wd2hveI7VH?=
 =?us-ascii?Q?rA48KZYkbXiNc+l5hFhZKHFdzUgzgW/GHp6oF/FiosusPm6MktkxO96mXIRq?=
 =?us-ascii?Q?EfnMCh8DPoVt9D/sQYSOZPsnz/HVf0vFMONFpRCV23JD47Kp+siI1/piXpgY?=
 =?us-ascii?Q?B5JhRq8x19/OITlSBkc9JnJ3S8qBUOHvQdfsatW+ALq49yyi1TKMLqIIHQEq?=
 =?us-ascii?Q?k/4vvppcaZT/Uvmb10kQwS7+1j0ZWx8AIqWqTsAJvmFMjmLo/CloaGzqiMEE?=
 =?us-ascii?Q?zZSf1aaYPG9aZ2v7UN1LF2FgoBXBQpdkIvtfaGe9CMUeCrvHDFJRKe7sBuGV?=
 =?us-ascii?Q?JFk+zyU8VP6lN+s9VRmg9rpEeu5e1FoOOq1QDqIDH2clHOVlAeFwsIOwiRof?=
 =?us-ascii?Q?SyZGwsW8QeeN2DpmTlTfgKOuwp55HgrWukSt305Jy8K4an+N/OQrTq/pKtxA?=
 =?us-ascii?Q?PC0mCgfTxyIOoesgl2FM+5PF4w/SNCkqmeWDiU/m8azke88Z7M3jygwqF7+l?=
 =?us-ascii?Q?MmsSAKzfhQLq+zQOeH9WxQ/HYNeI07ogCUCWz6fyCbPmnZMrKdiTLJiAzc0N?=
 =?us-ascii?Q?r8hpAD2iiOTwAgUbpuAoczFcR/5gJTZ+ytxDYWPHd+FoRav2L4WezNt+97i1?=
 =?us-ascii?Q?E8dYLDPvjAJ6tYRjZVZxKhrE1BkvoPmUdbs3E7GxMG2LYeXFammu4uu4RIjY?=
 =?us-ascii?Q?zvrmL4LArQYVR3fu9QSvA1yCXzvAY3gJxYFW9YnZ193Q02tLI92ds/CWt/lo?=
 =?us-ascii?Q?1eX9KLOmUZ2H7VZJerpDaiZQGvaEslWCc6ZBMkNZZ4/1qURHk6VShOGJy2Uo?=
 =?us-ascii?Q?dBv/s/prNMi1ZP6F9xgYVQlrnmthAJwg9oDZDKONyMH/Rv6FxXJwieKdfaV1?=
 =?us-ascii?Q?kjxwzZOdnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0ebdb8-6279-4c67-d0c0-08de632b2523
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:50:09.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjTZz0l12Mfdnxh731Ib5YT7kYmG5qXhkucvDP96YP7n3K9KnD+ilFySHBNiYLaZ5CtfT5OhV3og+0ajH9d4dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848

On Tue, Feb 03, 2026 at 11:34:07AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 11:37:31PM +0100, Andrea Righi wrote:
> 
> > Or:
> > 
> >     pr_info("%s server %sabled in CPU %d%s\n",
> >               server == &rq->fair_server ? "Fair" : "Ext",
> >               runtime ? "en" : "dis",
> >               cpu_of(rq),
> >               runtime ? "" : ", system may crash due to starvation");
> 
> Yeah, I noticed it was a bit wonkey. I made it thus.
> 
> > > +	}
> > > +
> > >  	*ppos += cnt;
> > >  	return cnt;
> > >  }
> > 
> > I like that, it should fix the issue.
> 
> There is one more issue when dl_server_apply_params() fails, in that
> case we should test old_runtime to determine if we should (re)start the
> dl_server.
> 
> I've ended up with this.

LGTM, I also re-ran all my stress tests with this applied, everything is
working great and the runtime=0 issue is fixed.

Tested-by: Andrea Righi <arighi@nvidia.com>

Thanks!
-Andrea

> Subject: sched/debug: Fix dl_server (re)start conditions
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Feb 3 11:05:12 CET 2026
> 
> There are two problems with sched_server_write_common() that can cause the
> dl_server to malfunction upon attempting to change the parameters:
> 
> 1) when, after having disabled the dl_server by setting runtime=0, it is
>    enabled again while tasks are already enqueued. In this case is_active would
>    still be 0 and dl_server_start() would not be called.
> 
> 2) when dl_server_apply_params() would fail, runtime is not applied and does
>    not reflect the new state.
> 
> Instead have dl_server_start() check its actual dl_runtime, and have
> sched_server_write_common() unconditionally (re)start the dl_server. It will
> automatically stop if there isn't anything to do, so spurious activation is
> harmless -- while failing to start it is a problem.
> 
> While there, move the printk out of the locked region and make it symmetric,
> also printing on enable.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/deadline.c |    5 ++---
>  kernel/sched/debug.c    |   32 ++++++++++++++------------------
>  2 files changed, 16 insertions(+), 21 deletions(-)
> 
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1784,7 +1784,7 @@ void dl_server_start(struct sched_dl_ent
>  {
>  	struct rq *rq = dl_se->rq;
>  
> -	if (!dl_server(dl_se) || dl_se->dl_server_active)
> +	if (!dl_server(dl_se) || dl_se->dl_server_active || !dl_se->dl_runtime)
>  		return;
>  
>  	/*
> @@ -1882,7 +1882,6 @@ int dl_server_apply_params(struct sched_
>  	int cpu = cpu_of(rq);
>  	struct dl_bw *dl_b;
>  	unsigned long cap;
> -	int retval = 0;
>  	int cpus;
>  
>  	dl_b = dl_bw_of(cpu);
> @@ -1914,7 +1913,7 @@ int dl_server_apply_params(struct sched_
>  	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
>  	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
>  
> -	return retval;
> +	return 0;
>  }
>  
>  /*
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -338,9 +338,9 @@ static ssize_t sched_server_write_common
>  					 void *server)
>  {
>  	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
> -	struct rq *rq = cpu_rq(cpu);
>  	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
> -	u64 runtime, period;
> +	u64 old_runtime, runtime, period;
> +	struct rq *rq = cpu_rq(cpu);
>  	int retval = 0;
>  	size_t err;
>  	u64 value;
> @@ -350,9 +350,7 @@ static ssize_t sched_server_write_common
>  		return err;
>  
>  	scoped_guard (rq_lock_irqsave, rq) {
> -		bool is_active;
> -
> -		runtime = dl_se->dl_runtime;
> +		old_runtime = runtime = dl_se->dl_runtime;
>  		period = dl_se->dl_period;
>  
>  		switch (param) {
> @@ -374,25 +372,23 @@ static ssize_t sched_server_write_common
>  			return  -EINVAL;
>  		}
>  
> -		is_active = dl_server_active(dl_se);
> -		if (is_active) {
> -			update_rq_clock(rq);
> -			dl_server_stop(dl_se);
> -		}
> -
> +		update_rq_clock(rq);
> +		dl_server_stop(dl_se);
>  		retval = dl_server_apply_params(dl_se, runtime, period, 0);
> -
> -		if (!runtime)
> -			printk_deferred("%s server disabled in CPU %d, system may crash due to starvation.\n",
> -					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
> -
> -		if (is_active && runtime)
> -			dl_server_start(dl_se);
> +		dl_server_start(dl_se);
>  
>  		if (retval < 0)
>  			return retval;
>  	}
>  
> +	if (!!old_runtime ^ !!runtime) {
> +		pr_info("%s server %sabled on CPU %d%s.\n",
> +			server == &rq->fair_server ? "Fair" : "Ext",
> +			runtime ? "en" : "dis",
> +			cpu_of(rq),
> +			runtime ? "" : ", system may malfunction due to starvation");
> +	}
> +
>  	*ppos += cnt;
>  	return cnt;
>  }
