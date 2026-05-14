Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119638BF72
	for <sched-ext@lists.linux.dev>; Thu, 14 May 2026 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789357; cv=fail; b=DXoeHhudTjAL5XzkpOZEOc25j1r3HIYX+uFM4iqqSMqq6rhmpg9/Aj+ckJOSwpHjqsD00Z2eP/qrK4yzRuJ8FBmcWRRqAwX9wnT3MgB0OzkQvVivE2RLbJn488ixtto0/VgpaKEibhGI59YWlW8dKeGoeP0MRSYjFtB4OwQYPls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789357; c=relaxed/simple;
	bh=O3cxO1KUqeZx0NmX4mtlWwpXj0wnqtCM8o+WXIa6E6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XLCT5o2SCAc+fNy/99xh4AVeL/KmfTgf79yFh4SPSqSOC+OxX9LJGNwB8LXb40hjvI+RGp5xMuHncSVqvMe+uFGdCC3F5zmhdNFRDodVzvwCCbzAGf3JIU4ALEPWd1OOYQRGmyecfsOAFumvOawkHj0VPm290//fm9bGdTOmhFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r4NAE8M6; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r4NAE8M6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVMNa4PDH437MNehn4hbblYE3H1WTbJkvWQbPIplH882mJ4isNdOEzVGr7mo8dvReONgPpMbuE/PuojOjgixF3gi0Lh30b1yMcDe0aigWnZJFDWOIkYDa/sKRBi+cpUK9X3ro3JVgCeXRMK2n8hPkrDZ2dSHuHNHjRevLABLSbfIkv5BvVlM1ZsYYIEH2wO/OUEcEw8Ji8UwCbsEHpd7dgm9NcrsWshoHKFt6moru9X8+bCfcIhz0Ez1cEKBATtYzNOK9K8aU3oHEqlYIuq2OHAo+rqtrrdaVaE9mwGyude3a2tznlVszDKrqgfMiIBlVz3FohoifyYrK9yLT/BXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hrT5FPRM6tuxqQ1gwLz5e8507s9LDaADI4mhqbgxiA=;
 b=lSQ4ZiuwZjOp/9yj2efqbjwdjO0N9x1+EixXmRpeXLV5SsLXlZxaMR1P50zpPekhJqHk7/KcKNq4qHpt7AYMlAuivKlqH36oF0fxmDkIDVkrqxS0HmpyztvujjQGtgaTLbhY/U0wDDO0EF5m6SJ7+stXbGGWpzfeZDvWhCc1LBxGg5Xh6wQ4rNDccEbfKsqRCv7hc3IAonSikcBk7Y9wgxOArRFCXjypiTaGTE3Z2dos0drt/i9YYYmF49A2sWCXvT+I2InaiAxI3chktFMzi9YwrMM0Wq2nv9tnIawi4FR+2/eFekZBn9G8HJZDeAaWZlOAGdlHjZ6rRgnFAKYCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hrT5FPRM6tuxqQ1gwLz5e8507s9LDaADI4mhqbgxiA=;
 b=r4NAE8M6hv5Ok1V37hSVMp6P9HycKsDrQiEpVzG85g1oZ82ZJSSmuCODq5T6tRKt6prCGq5UJEIx3eyIHcCJgRhD+nnvd6BFvJHj0EKpyyCmew77hESLG7ooHZ+nBEX7WXULlwtSFa4A5x5uLs5kdgOYWYMC9LfVV12wPcjYr4DOOQJ4GP6JOwZ9bdCPg8Zu3EOvnyLRHsOK70aj9VtnUo6adFzyIRr4PmJvuCi1nUE7+GttOhsh5VGGo7UAZlAI9OEY9wdRktc8L4ZYixHMzDMcGNpzrwLg2b6r7HsLtMA/Vjol4lKQyqic7qVRKjZ2zfTfS1u8BgVbmLwAOEoYXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 20:09:12 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 20:09:12 +0000
Date: Thu, 14 May 2026 22:08:53 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Samuele Mariotti <smariotti@disroot.org>
Cc: Tejun Heo <tj@kernel.org>, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH] sched_ext: Fix spurious WARN on stale ops_state in
 ops_dequeue()
Message-ID: <agYr1RbafGUevfOH@gpd4>
References: <20260513095329.4029345-1-smariotti@disroot.org>
 <agSKJbtmpRPLgYJW@gpd4>
 <agSpf9QRx4zqhZxx@cachyos>
 <agTYojgRwDH67QMC@slm.duckdns.org>
 <agV8-RlKEkiAbd-h@cachyos>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agV8-RlKEkiAbd-h@cachyos>
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1f5d9a-f060-43b8-6220-08deb1f4a93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|4143699003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5WBgPPbItKOvSxCyzz/6+GylNwpF4AEnk9+ZGmhbasvb+b0DwsP1rljUhgQi7GSs7W3H8MbCegj7Jg0DspDSEzP+X9jYcKeHqAmCthvj+l1s6O5oeb1kJqOotkwJN/R23Vz1JgW0L3OM0s35F7oLxEAs4tnKrxcfzxIy4F/ef4Z5lRts25lHmrWwu4Wa4845FYo9f6QurjUBLi/dphadwnPr3lR6OTnaHwg9FhAtRLAWm4iMrUZbMyeBQn4fjHu+cTAHlq9B1kUvTiDGIptZ4Yh2izofqKZFimiVssZbeISHoJ+udiaLbCrswhFBG59F8WsSmF7eiXsBmFuQp5Hb81HVNmHF7Pq02rWYkhBatSLrHYwjeJo018CltR++GjssgpxGkuSYJSA2FMF42cPD1lkQfGEJvmm8wdnikV+UAfdPkzKVnehvrRWAw8OLj7lafmoX8YWW4v5QxUGLplR9l9g7l8HV/CGLoQqDRlNEp7PyOUBCBFPpuwz0wweIe0REa9JiuQ/YmqiskIQWzOX6hnV5O211vlujlJ5u70Jtx0uooTe53fjAPqI21Yz28Rr9ptYOF5IAtCpJNi6jv1TjzIRhhGyVfrVkr365W/tnfVScA7amZdxnCmO1npGd13FetmVUssGOS3kzLE9NBxIkW5Oa9BCFh4Wf/2pcU5Ti0+ohvOeTvb2dbrrLNM5P67OO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h3oBP6yBjRczKIlOVYcU0RAZwtKUuFHMt30q634Oin5FRcfRQASmlX12SUkv?=
 =?us-ascii?Q?1/Tl8P47E7qZ7eysEfpozNEYZu3LPbU8HczSVykrCJXY+dIJE/kslXTj8H93?=
 =?us-ascii?Q?QbrQ+NJ63ai/oFiqJL4XvYmxAg7XVqKJWz+B9gDn5QdY+NJoyklrdo0F1zra?=
 =?us-ascii?Q?ldf2BIdviXmy7QyrWrOVx7AsPsM1dhL1d+Yzv86VIIrqy5aO2fxbDYJGdirv?=
 =?us-ascii?Q?A6/2TI1WV4AS3AlR2UyLkebDytRZbVsJ5NTrLUrijLwZNf44bzZwgV3akyG1?=
 =?us-ascii?Q?Aqf5QWV9X7LmHA8URskKADRh4KD20CnUZbZjii3yMUGgKUk7KE378VL0sref?=
 =?us-ascii?Q?TFTkXxOoMLcgI3ZU/kS4cl87Bz99VOFDnwPHJjL6+ToFGrlwXfaBIzlypueB?=
 =?us-ascii?Q?7c1Oi6lnI0Yi1G7myA0bIFz+9qkiVNLD7xs0qpNcTXLV3gC/Bok4OeDNx5/+?=
 =?us-ascii?Q?np7Na8fVmodJZhG6dUDsaqOIAy5FoN0jBzdAgvRgbmLKhVtjIlpLu6ngNfJg?=
 =?us-ascii?Q?CPE2gTAkeZgHD7rLyXDifgwAZHHbmSfVc+m3746xuqFaBOxV/LDXfgnaCLHs?=
 =?us-ascii?Q?kI0pvqNwrwYmG8CsrXG2MKWV6QWAILf5c9XVbtLRjHo8j9TacVB6hzDi4QIH?=
 =?us-ascii?Q?z5ZC+dzTBTdENfcj9sQIetSNeSBHmXqosC5yPNZmvvbQYHchLAtvVxHX4gU1?=
 =?us-ascii?Q?q1d8S0aCxpVurq3/YoAj0b1QxK6JlVd9AcT9MMUz/mlIFVWAZDV0SHYJ+F+q?=
 =?us-ascii?Q?xjzuF1tRG0ieASVPVMcfIVpTvg9JiLbjcMF9LW4OO4jBZkf4aNk6vmkycd3d?=
 =?us-ascii?Q?mCW/wRFYkSWC+g55plrbsUh/CviqmylZKTK4oh6CaAjYOLwdS07yAt/LVYP+?=
 =?us-ascii?Q?om0AqxQRQNUSqBIkh53D9FbfNytgY2hjPjRpoPtGCp9rHT9sihV+oXKgImaz?=
 =?us-ascii?Q?MH/+P1cAQlWUcBPxg1vLUYLdwAMS6Cq/Fu0cQu/gs/pyHaX4a/w01fu8rU6I?=
 =?us-ascii?Q?Z5Df/UEbONqdhrGv+Ads5F3VN8pD9x0tXDoeZt6ZDyCA1wyPhV1CO5/j9f8u?=
 =?us-ascii?Q?fD8pWU5HWClfWRDzDr08bpr4ePY6DpfjWTr6C12gRdSLckPh/zOQRfZD6Py/?=
 =?us-ascii?Q?1eXr12gf7RClFTtSWfLedNEtClmODqET8qNOdm3Oa3bJAxon+TRKr+m0iwyE?=
 =?us-ascii?Q?EZ/fDwyvH6JnSE4VKZFvOMNTP27uSkyH3LSiEL2Af9UJ4ELUnV3sV5HCZfSF?=
 =?us-ascii?Q?ckkz1WR6lFckGU3G4MLOfqRUP29nXCSwlmpPvUdUVzdqX8tdhBhDmxxSaGwJ?=
 =?us-ascii?Q?aX5c9oE+zi6pwjqyydvYjgRioXhzGS7EL+VgmTSkG+RQ0ivKXjmS0wSUKrKX?=
 =?us-ascii?Q?Gb1cXARDIUngJf1/RsLSIT+CLdElp72OlJw5d+z9Dclibv/e459cmt6K4ilj?=
 =?us-ascii?Q?iRKgb3I7E2dP6/GkflolSH/4cdgaF7KQFZo3ttFGp/TMOdeIJwcgE5s1JX9D?=
 =?us-ascii?Q?shzeve23zsylTWsR7M4cMUbunc9RMQXjuGie7uVcak3zkCS08peeR1xUmskg?=
 =?us-ascii?Q?f2QpOWTz+siJO88+3PkmxdC5i1YDvfJuEQDsFwDeQKMTGrkYv6euahTMxdMR?=
 =?us-ascii?Q?Qob9VKQZEBoBJFb2Gh9tto1gkkfT9MG9WgvV2ObyJVZylscP6xBCUYQOCKGk?=
 =?us-ascii?Q?hxmhW/7nJCPfGLgCgVEcZ5Z0CZnHJimvOuWrXG7hQD9GKmLr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1f5d9a-f060-43b8-6220-08deb1f4a93b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 20:09:12.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0S8303Ssj1ZjB2/TqYTFeswndzrkXkfCcB0By5xuQ/mhgUV96B4iD8Ke41fTzYygEjAuW3w2HzmjZ4yWIxTzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

Hi Samuele,

On Thu, May 14, 2026 at 11:13:49AM +0200, Samuele Mariotti wrote:
> Hi Tejun,
> 
> > Let's not do the WARN and exit. We shouldn't get this wrong and if we get
> > this wrong, it's going to be obvious from lockup detectors. Can you please
> > add a comment explaining the retry condition tho?
> > 
> > Thanks.
> > 
> > -- 
> > tejun
> 
> Thanks for the feedback. If I understood correctly, you prefer no retry
> limit, letting the lockup detectors catch any real bug. I also added
> unlikely() since the stale case is by definition rare.
> 
> Here is the updated version:
> 
> /*
>  * If SCX_TASK_IN_CUSTODY is not set, opss is stale: finish_dispatch()
>  * has already claimed the task and cleared SCX_TASK_IN_CUSTODY. Retry
>  * to get a fresh view of p->scx.ops_state.
>  */
> if (unlikely(!(READ_ONCE(p->scx.flags) & SCX_TASK_IN_CUSTODY))) {
>     cpu_relax();
>     goto retry;
> }

The code looks good to me, I'd elaborate more on the comment to make it clear
that the retry loop is guaranteed to terminate (not a deadlock).

How about this (or something along these lines)?

 /*
  * A queued task must be in BPF scheduler's custody. If
  * SCX_TASK_IN_CUSTODY is clear, finish_dispatch() on another
  * CPU has already passed call_task_dequeue() (which clears the
  * flag), but has not yet written SCX_OPSS_NONE. That final
  * store does not require this rq's lock, so retrying with
  * cpu_relax() is bounded: we'll observe NONE (or DISPATCHING,
  * handled by the fallthrough) on a subsequent iteration.
  */

Thanks,
-Andrea
