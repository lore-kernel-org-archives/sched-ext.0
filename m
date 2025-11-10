Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B82D6E55
	for <sched-ext@lists.linux.dev>; Mon, 10 Nov 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795871; cv=fail; b=vE/sA1SPHx4d15jeqdg9HE/GvKuiio58uHGdqtQB5g8hS4OrCSuza1xlCfG3Xfc6umhAefoZyAGrnehC1S/sFRiizmLrBzDgop+PR4JwFm3INJGfQVV08qnouafnJy2VPiKHwnF4hdwyGkG9XlUQVY1FYACViUVlNC4CSBXWRDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795871; c=relaxed/simple;
	bh=NQaxLIkWrqbfUIxfO3zfSkrc1ljPrnTBN+JArYyJzrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dHqx8VgS9mPM/TEcAwfPE7M36e6t97YtH7eKXnUg3vRtOjjF1Xf6poBBguxV9F0a6CUaZWe+TbPNogL1MGg8LA2e0ebMiZJUagYbkRDi9mcpvMDC1UKkkHR7fHS4KRZE7ThCjDac0h55acKGUuflq9L6kq77s/raziGwG/TYtPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e57l83bB; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e57l83bB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXdn/Pnmd5S35qnq1vbpqOFgEx5Ik/CvCeGoX+gHomzH7LaONnzsskA4Wf0SOwaOXii9+QlPtRv7zSq7rV1Wa6LcFzcHuvp+gyHE2IhdF58rfLzcTI4dCKm/SyiG0zXfKyWI5YZdZBlsxHsC+BCRGVgP8aewtYM7IAITqsR116oeeOvPJD9GgAi0erEFfJ5rBI5XmBd+E0EyggyqxJ26ifUgr5CHd6fDXtiXow36EGLObpTMtHq6dYPwN37r7MiZ4qsUbUfCuUKG4RHUgRrXkMa1JKihrE4HM+W54S2A3ylqGsJJJZgZajI13BJrIgS/nFJAC2ikVa7UB+BiuxSi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwsCO8H+tMNhoRXRDf1ec7PWg9yzcuhNX/3I8PZaSZk=;
 b=e9DSNaXq2lAzm1BZOIUB7w8CtSLtS1ElafwwYMHoYl92pTvKGwDUxaJ5SjHma8oDEGCjgLXu0x7CGT3xmSSuaTVWEQH/UR9YocFyqO89nKurQKcMrXjohDFmFnoYbpgpuY4cc3tUafNNeytcN/uV3FIvS8XTdzKUpcNrlYrPyIX9H56YuLzovcJ4/e4soNnSZANWRXbYTqad6Y/vbee3hdJF+oXj8RfJjGrQ9stG8QAjqluWPAFwZ3Gn4mMUenvzR5ZgcUOBOxlKVTDgEOUcYpXD8rpJLQDVXwTfvxKlE8hN8ij+lS7ao9cWvzlCLvqUY+Pe++OCYjeKCKatODcAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwsCO8H+tMNhoRXRDf1ec7PWg9yzcuhNX/3I8PZaSZk=;
 b=e57l83bBV4YIUHtM+dwGMpu+71A2Uw1i9EETu2XbS3J7GIZoyTy85lSKkVLltIT8+BcPWSG6KyqN1u76S1JxINuz3xvvtHl+3pXaHCLse/0WrmQKUceBKvH5MxFzudCh5hXpiaRG9kPx7lOw/YDRvgn0Qqw8dfdPpCql28H1aJSiNPQ16lXw9KS7irPtftMRm/N+aG6HxHHev1ylWSDGkO4zmJmL/9xY8X1YDxqSPU6tGRdfgHLFztV/eQyMD12bf3FvVzdkqAcQKqQ/omfHSIvJ3EZXoR5dmGFlc/dyx+FPnJSnma64McqaMvDpyPr14aPZw5X++3NyQRP4iGd2pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:31:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:31:05 +0000
Date: Mon, 10 Nov 2025 18:30:56 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
Message-ID: <aRIhUIcDnjrGIoJf@gpd4>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-5-tj@kernel.org>
 <aRGXd0QwgqBVu7Gq@gpd4>
 <aRIWEBDmjxScAsyP@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRIWEBDmjxScAsyP@slm.duckdns.org>
X-ClientProxiedBy: ZR2P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: f959d75c-a0a4-45fc-eb0c-08de207eed7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5dF0F570G3oceIyrC7RmyjKjOdyotYkWwdegqgtgK3fuOh7dh+MuEGh0MG2i?=
 =?us-ascii?Q?8Myx7BB0n9eEMXW6V6L29RyGj4petQYqXyvDS95j/qhSzh90DJtG86WO0byt?=
 =?us-ascii?Q?FdBPLpEiW42mapYjdug/i5C+3+kHNbEl3hakeaDYEYEiphikxHmLFQKghMqj?=
 =?us-ascii?Q?4TSPfOEPYgX1Uhb8dcNaHGr21VWwUAHnHM8Ca1vur+3hCb0S38ROKP/zkGTD?=
 =?us-ascii?Q?pSsCk31MWLf2V4LjXc5XxjSNrfe+jVoNH4UjAnWIlXV9QoDg5VJMezMVYdWq?=
 =?us-ascii?Q?IKoT3HG6TmGpqYSLWj7F/lxPhCaN15RmTIlXH2Fvpw4LNBcgDYffPY39yvxS?=
 =?us-ascii?Q?rd7YRiYS0pA7l47aOrn8zAolQOG5w6kZXI77H3hNxmbadmgGakwyIk6wtphJ?=
 =?us-ascii?Q?rPxlvPgcwN5DOJcmWUwNBtpf5SP20/6PmO8q3p0ZQK3juBK9kxXbSiA7dJCy?=
 =?us-ascii?Q?/ttxkLFKcAQupf7nPIZLp8v+devw0Co3GjlTR8KD1k53n32zchj9tfQlb+q4?=
 =?us-ascii?Q?9CROE8InPnPY/7FPoV8mThbyfxEhiHS0ny0059+zZqTCqHPMV+X63n4IoWmp?=
 =?us-ascii?Q?W9xRyT+GqRqSEGl6rAX7Btvd7vKrjnJORbQDKIgbwp++vqr47obKfUX+BSwD?=
 =?us-ascii?Q?O8f05f4aTT2svSEE7Q/GfgPYqqEwC47rS0fl9lL+5oRajFyE4KlIE9aQo7PL?=
 =?us-ascii?Q?+NN92XX7Jpj11kpJ2iD46CVKBxqAMGFqrfgji4gCGgRMXeAqtIT50CeZmjwW?=
 =?us-ascii?Q?+1IlabvA7nJtKc+SQb/DlgWGNDEjg48nAELVc6/xf2RzsiN3uB4A5CSPDRmb?=
 =?us-ascii?Q?5QVPbEQGEwwr+Qksq4GxpABttg4pZ5LsAymyDNmBEEPtf0EwTI9/CAnrorjo?=
 =?us-ascii?Q?PP42m9uNfZVhqLbGQmvaxR2FCzNoyz231ArEYTMay6TFt3utho8rIbCJjKJV?=
 =?us-ascii?Q?27GUd0fnjRNxdaMMxrG3Fg1vRwGoFgbnpVdsDTLmETk5+oK9c669eJCHNlA0?=
 =?us-ascii?Q?6jZZo6Lqp7hA+lHMJ6YTYDFIExnOb1WWYLY+emyxuzL9+kODt0i01GBToYKR?=
 =?us-ascii?Q?zVEX49r3g3eGSw1Wjzw37xee+3bG5SfaKD2ve5v+13pbNqXwUEMN4E9FyxQW?=
 =?us-ascii?Q?f1xpx/hwdMn8eMZxB3QN2I4H+Glg1EKiXT64VJHR3vZ/4aiyBpmz3mMV7VNA?=
 =?us-ascii?Q?x8klMugm1lBSKm6/MvMTkeMHN02Vd8IAq4kNkrY1t/s1G+qzsk0F2QS3hV/0?=
 =?us-ascii?Q?QLB6LOaJnCFbSMzR3zXcEH8L19NjyZmoB8/FxHVz5Vx6iq9wKxFrMEf/mEyY?=
 =?us-ascii?Q?LD8FoFGn0k14trRmsQadQWX8668XgJOp8/vJRyz5WwBJoUFQKxuPbepZHwJA?=
 =?us-ascii?Q?AFHMg+mhsd1TCb1L9Glk6fktW52EnZOnLjLeg4mneAh4/wOZi3lKUoZJrv6C?=
 =?us-ascii?Q?L0yxgxMSWcKzDzsZ+uUSixq8zLRXXnWp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rExOUGX34bjiyUWzUYToMJFfom24f3vMwMs4ZNPGjnvUKHjROMAYQhCiabDN?=
 =?us-ascii?Q?yfDub0wbwhMQTRYP8uc7R+p5cPSb4PJPjWg0fWDDz9D789oQLgpkYKc09CIs?=
 =?us-ascii?Q?TtdaSOlKKo/ZYWFA2yblfRq2vXsAWNDt7LxwV+RFWd5WwUqIdZWEjIjFXvT7?=
 =?us-ascii?Q?GXKReg9AXHTDrKY9pkkqiz6BjFB7mVNSqi+clPQf3t+jfmkrVoopkKbcma0e?=
 =?us-ascii?Q?Ibag6GIQPNA907J/GUTU3StxxF79osdBWbxBik5fEXrrY67+UfccNpJvyo7N?=
 =?us-ascii?Q?XcgGTpWcw/IXH+zIrKltZMgyw0n1pXSG5A6nNRoqycRA/AABno/ns/EG1XNi?=
 =?us-ascii?Q?fYqTuHiSmefjvX9Vcwy6HxmzgX9U5u5895Hdz8k293pv9sixJchSJvpw306v?=
 =?us-ascii?Q?DZZjI3lciR8UpBirVdUBzomfr9L+eE/nzki8yc+XAUTifYoSaFUll/9kTK6f?=
 =?us-ascii?Q?sGvm+iwC6/EC5Kbcrsb9vhHDCn6ljzWDk1U8B60C+dOLwJsLAba5B9UnXRyl?=
 =?us-ascii?Q?fZZnLdva1u5t68mkNI1Eqg4UPkCD2BzB/vi7E5LwBQIUt2Zue7CYrVrepfEJ?=
 =?us-ascii?Q?hwHgBrGrTTBRdof5yYJQdJws1QJQVeqc8PvsfGoTNb1H5bzqteAgdnV+tAbF?=
 =?us-ascii?Q?RU7DwivW/LZNXGOp7W8Fahh6ENxNDLboJzH8RywSs7a8TXtYoOoN4RM5TaUA?=
 =?us-ascii?Q?eeNDThIG2UeCtp8V8V/GcbHQIXjYMmS4y6HDGQwuKleKPVRCNmfhlE2uD5KO?=
 =?us-ascii?Q?7htzMqUN4TLIXrBdMk8XxRhqloZp73zJm1nlZrrvpyUaFIvsRaKF7rZwRa7Z?=
 =?us-ascii?Q?/J8QFxkbIIUot8pw/znepE6CMh482yneFjoB9BF037DAvGifMIauRq0NRsCJ?=
 =?us-ascii?Q?N8LZJlY/GOexo40KERKWcr3LnZbt28NwMrYZQJ8DN3mWkYIV61clv7LPEkz6?=
 =?us-ascii?Q?UMZ6pTzGsNOnTGydZe4JrvyUSPXn1YEg5BlCxXScOy1KjCPCwiBmfsH5y4H0?=
 =?us-ascii?Q?MDn7+qqWQuFlfoDFWzE5i4u2H0qA/2igWEo4mvXE6pqwKqMTiv5dDNb/85Y1?=
 =?us-ascii?Q?42Wbr+vO0QKQb7265SU2slOcvfFiIPQiGQ40EMytaHShsICyMVdjGbKYN5gc?=
 =?us-ascii?Q?eO0QBa+jXiKZeyZ8PIXqyYt8c7aDeiRHkPIwKhfWkVKwB6P1KYEArFb++Tja?=
 =?us-ascii?Q?4yHJj6EaCP3f18fIWs1X0YZTJ67+09FN2XxiMuwoAX1w1qDXqQ1p++zbeuZ9?=
 =?us-ascii?Q?RnanipJpdqvnmtpJcanlAVMtq6MaC1wv88Mb4XjLge7Ob+3DKqTmjxc6tjGi?=
 =?us-ascii?Q?cUZTIt8c2E9JKEpMi0FaiApge4qZz6jWQ2LvUZSnYNkZFu6Sb2G242vyBZO1?=
 =?us-ascii?Q?Yzd9otTZrQSzEyDANcF5Ns4vXr0bsqj5axUhkBwWBrijdQ6VUkThD+9jleq0?=
 =?us-ascii?Q?kegsoEacd13US7dPb2O+qPrsNYw/l8MArVp+7raB+5D7i251tx9oUekZHIsI?=
 =?us-ascii?Q?5p6MDxDQUtB6J0Hvna24CzsS6Mq7O12I0KZsG5krcqya6BdoNQr8QoTQwgxV?=
 =?us-ascii?Q?VOVAbeGekR2qD5N9cfln8A5bN0J9WUrPVDUFHNiv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f959d75c-a0a4-45fc-eb0c-08de207eed7e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:31:05.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQPwrz+5Y4qsakGHXHHQu+tvb46m9XaqmTLK6zqLXebK9cgKggq6DK/GI1ekMlHoBDBRcpRfxiwH/BlA4Vp/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

On Mon, Nov 10, 2025 at 06:42:56AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, Nov 10, 2025 at 08:42:47AM +0100, Andrea Righi wrote:
> > On Sun, Nov 09, 2025 at 08:31:03AM -1000, Tejun Heo wrote:
> > > Change bypass mode to use dedicated per-CPU bypass DSQs. Each task is queued
> > > on the CPU that it's currently on. Because the default idle CPU selection
> > > policy and direct dispatch are both active during bypass, this works well in
> > > most cases including the above.
> > 
> > Is there any reason not to reuse rq->scx.local_dsq for this?
> ...
> > > The bypass DSQ is kept separate from
> > > the local DSQ to allow the load balancer to move tasks between bypass DSQs.
> 
> This is the explanation for that. More detailed explanation is that local
> DSQs are protected by rq locks and that makes load balancing across them
> more complicated - ie. we can't keep scanning and transferring while holding
> the source DSQ and if the system is already heavily contended, the system
> may already be melting down on rq locks.

Ok, thanks for the explanation, makes sense and it's definitely better than
what we have right now, so:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-Andrea
