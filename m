Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8829D19
	for <sched-ext@lists.linux.dev>; Mon, 23 Jun 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655733; cv=fail; b=HzRQlmRyhsT/JhPAyZgZrYaIt1GrxFlRhDX5JRrOQF87rnkiV9OgNfbcRKvv3ljiw70abqi/sLY1+X8jCoTN/YziOSlwIWmfZaAttPLl/hF1jArrT5orhnNDFitgxLwRKjP80Bjijb+0gq22oQZPdzX6rOPQCf3FwlubWKBDSwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655733; c=relaxed/simple;
	bh=KPkfKUaUOmH6Ao07QhGKshbvhISIDG5IbtSpns8Paew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UCsQ1L0dtWZMj7tJFiRNRpoNuYZ22BlZqFLoQ/j9y20aBHyEOcZaYyf+pBofEhIgOHKM2U5/9NcaktcDgK6K+seO8n5KrAH8go3PdP11TJyWPIArn8l3Ud3vrngAh0HwmweJTTyOuo1lCpN4ovQgXnqU0WtPy4WzHLReqYGi0Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjDbwInO; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjDbwInO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipug9y5NSt9TDHbfOa+XtqfkcOCumlzRMCbBs+ci/8WiLxKfemMmATew49hJ2W+YI46s145bX42JAV6RbAulCaLvRFo+R77PXNtsSJzOt3VAbfZOynYwNQcm2MsI0kcJLFwyxpwxOKNsIooetTN8LbjNFJ2SuLjFX7msnRiOkoSYai+JXcWvlkJ0QVxSR/vsq1+66bM/us0OtWAn+GdvO1VjOZ//o65SB46QEgIXfskuesx+XFBUjcJGTTXmxvUvBtdy1AICa8a+eI+Ov5OLe437lO9lkFgEUYdnA4R4AkYYeYcH3VOAojYDYrJV992+o5KAbGIiVfY8vEW/2kIFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccxpg4ZEa9yQZDt4bqk5C2fZzaq9Zrm6i82dIWh1MOk=;
 b=e5HXjhg8bxm5x4K3vTWTkWphLHKe+3NWI9zz8Mj/HSSkHFaNdnDYOCMQuSvnrK+jj5QAy+cv0EuRH7PdshYSoHUYYwtwegLHuD1xIp2py/13l8DbWiRGxKoWxeRLVvnIj5X6wtXT9EYZ+vzs3OviXUSOTSGA44ipROcvabp4p9ASWZ3JF+b8zxpEKs56jNrD3hyWtTy7PLFwuhpX4N+Y0U/qixuxqLdsuuWrgvlZFCtMbc6ILtp3gGrB3cMIVjtI4nmK24HPTRhdb6/PHsKljLpeSsgaqn/2ccIkaNJkt2ZKhVjXawy4MXmus2cAQI7T9oEFwiJVHBygoZbV1V0nGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccxpg4ZEa9yQZDt4bqk5C2fZzaq9Zrm6i82dIWh1MOk=;
 b=RjDbwInOWKu/nrU1kR0yjyGID2D9SzyEeQZzaNEZkFHKEC4sTi+I5qaeHMyo3INYw0nq3z4J+3J8KZC7KKOLKHzGIQhJ70u0SmhCOx89oWu22fbF5kRTLs/Q45zjqEBH1nr46VOMww6DvOx7sh9IsSZbSOsUQmyYDuuvzywQgrFIj8hudlih1X+4Ow+oEl7Za7glI9qwWe+KbayVHhDFk6eIJV1jZ9ZwQEDUS/x0gw9SmwJt5wXaU077eO4R5MOPL4B16eQhX8vBNp8P2GvhZ5B9N68VrI1syrKfyfOhpH8+9Y1snxFK99o16G0Md5xLBvn/rGl4RV2gkHxrBxpHdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 05:15:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 05:15:26 +0000
Date: Mon, 23 Jun 2025 07:15:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Henry Huang <henry.hj@antgroup.com>
Cc: changwoo@igalia.com, tj@kernel.org, void@manifault.com,
	=?utf-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
	"Yan Yan(cailing)" <yanyan.yan@antgroup.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2] sched_ext: include SCX_OPS_TRACK_MIGRATION
Message-ID: <aFji5HozfgwzRj8L@gpd4>
References: <20250623043220.63793-1-henry.hj@antgroup.com>
 <20250623043220.63793-2-henry.hj@antgroup.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623043220.63793-2-henry.hj@antgroup.com>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: 104686e4-3aa3-44de-2a06-08ddb214f6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eLrlhmLPI0NBR3QarGk1cARPDby/GYEjD+YvtgSMIhXSv8PeaVUJxZ1Whgth?=
 =?us-ascii?Q?6wrQ5F/zQLnnMoiD4NY8v41DAG4SjlPrCUszNwoZdYmgpAY9UKxFp/zk+9zm?=
 =?us-ascii?Q?2ZM5jscBiTRDxhlHLz4YLSzFbaBRvwxpYiDeOUqoHvMQYOfeZi78CYIBvo9J?=
 =?us-ascii?Q?Brel0Vyp8/Pjv1mUV0rPvZDvpEZS4poGV8LhzQuziRix7LKJ6veo2lbT61Jc?=
 =?us-ascii?Q?a7q+uhgdTFNW+mHFXQy6rA0VkMzvcEr4XGTaMizD+NGK4chrU8XRMDMwuytF?=
 =?us-ascii?Q?ClRt5jvHkpgblecebE+q/D2DSusb5mMmOmVqlf1qT3o0QUzITyRJuk79oM2y?=
 =?us-ascii?Q?wk+6yVrKAe0vpFZtw8qwgkpviYvI+2FAWbb4VR6A5KbQQuYzaYp7uAXilJ3/?=
 =?us-ascii?Q?fJtLiHNXQCk/Kx3ZyBdy8vhGayCu0VgFsb7Yr2qHF7+qAP7Ni8GErZ+pD04v?=
 =?us-ascii?Q?5a7QEoqJmQLNhlHXDlzIL4nDZyaU4Z7pJfzzh+kpXHw4FeMQLV3G0KjrYqfZ?=
 =?us-ascii?Q?U6JTjnC/l+n7B3eaOBKeVNMF3kcRHYtlVcSSPH42iT8eZYyG2TSqFK1uIWsK?=
 =?us-ascii?Q?SlnnLpAacpwrs25fyCM7r5ZYR0u0H3FBWAUYyb5QI+RimuehGCA3QLhIZ6A+?=
 =?us-ascii?Q?bT0pXPoeAATWKKGKa1T2ceSt7urX9W3uDQ5jePIWuoydsxBWXSeXc6RqzIhx?=
 =?us-ascii?Q?CBKIRQ+UESZohFaHpYjglZ9bWvSHavVJ1ELzvKq7HYVkPal5eu5X7m0z2kNU?=
 =?us-ascii?Q?ky1km9inhxIaMT/QRML8n22JWyCWZWyvJcwaZ3LMPhOHJqbaBdl1rZ+ga2W1?=
 =?us-ascii?Q?rirCBuAKlvTVTfFiHJVIMFwS3DZCyPpwbf5xbO/N28dRc99Ek7+Hm2Ki25fB?=
 =?us-ascii?Q?WbR9X08fqgC2X2E5si/KmT+grbv3nkNQ2HMa0uDeu82eOIooBGo9BMuK32eP?=
 =?us-ascii?Q?o4gDGH9XNoZmjmKj7XGuTXMUKzftGORMm5CiDafjwirirBUIH3KNz4nlx8ml?=
 =?us-ascii?Q?DT3OHviU1ZEXDDD/00dAArmhWXkf4M45UVJF/8uSevKtvDHO1wXfgRjlMU1n?=
 =?us-ascii?Q?tryTEUEVi0QnVNnfRpTKsEA4yXJUAlh+LKFaYocwg09XqOAzySknvZzatMJR?=
 =?us-ascii?Q?noYBJYLnr79dtTmdk7EKXxD4TdjItWXXh1a70PJri21syf09W7vry0bZW0Mv?=
 =?us-ascii?Q?1P7DUR+WIlvqch1Gj37KTu7lAebrOLFiOLV9KiU52iAWbSzOtZFWEOQnh6VA?=
 =?us-ascii?Q?lmQwtLCDDI37vk4VUkGUgRHI7V/o5XqGn7ZajcfVuKFAu/1XGBAsjqWGxky1?=
 =?us-ascii?Q?WWc9tB2mu7TlFV6TnPJKMpJHAEfhIz5zbKyPl6mPodXbTnyQOUligFpX6pQY?=
 =?us-ascii?Q?Zt6qyMMMK7ULPw5gzfAGgQ78tFX2QP9UqwHhuAugOTOdAgvuwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xvAjSbml1AgGTFx3/BPNwzpJGLo8ccrOzIhRxJkISv668BejAWqe0ZexRgew?=
 =?us-ascii?Q?ERjAL57OmfMr8EmETzzzONB0iPrElpuELuol4wUiv91Yiu9BjNeY48nxw25C?=
 =?us-ascii?Q?4s3/vXHzEG8QyaH0y80LrVJHOBvHrT6lDu3IHDuaY3+ttvtpvGQSwLngyF52?=
 =?us-ascii?Q?MVC1EUdzPl51b5D6+xStvMsJuz4tT3TfOntrfPrTPZdLenxop9aTgrduKFC/?=
 =?us-ascii?Q?0HDPmqwerN4VT9hGDSiSxwgZj48bbMXEnWPh0vzvYN+iyuzcE+Y8CgsajoAg?=
 =?us-ascii?Q?JIUwbDWgC+Ln0/fOW7yabOIDWtPi7a6v198WIq6vZjT0RGDolsaQACHnOsQ4?=
 =?us-ascii?Q?wbTW+ZyakJ8Tb7c8ouuj4UDWBnu11VbtnokyZ7jMwssRGeStpa0uJjmjf7Um?=
 =?us-ascii?Q?DTH+BuzbMjjd7n76bivgT3/Hambk/03/61fWXe2cErWXNUW59eMzvx481t/g?=
 =?us-ascii?Q?U7/f7P0F6IBAF2sZLf2aV4jORGXyBX3q/YPodnj/WzGxs4+ld0gIAazagIPa?=
 =?us-ascii?Q?ed3nR+vJAKWbGuZFGD0pL7z61/J3qqz2QnD+j/jz/62cGF+Iw2DJFYdlj4JB?=
 =?us-ascii?Q?wl3rjlwY7z4I7FbxCGON8MI03RM8Mc6kdPl/fSIPNQ1EkjNxQj7B5ycQ4y0W?=
 =?us-ascii?Q?8lPMz5F6MupomOEBCLe9daukBV/l1MS0lrn3WVbxkDxQvIu82WX5HDhEUHpV?=
 =?us-ascii?Q?0VTolq4fvdiHmWIcV6p7pq8CAG9PRq28dEnd4jzet24ehQkJaDIEciXT1m/k?=
 =?us-ascii?Q?t9qC+DSA6ocNAdl8qgdCalRK3eJc1YOkAJLyuGTGBA3GMagSJClevkVmv5Sn?=
 =?us-ascii?Q?3FTiE96bl19yJVSH8YeCIbU5nbCNXizUrEl5lf7yd4pzZdclYaCuXafuST5u?=
 =?us-ascii?Q?qNqRBwTl80+wIyvUv34DM0LjnXm9ux/5rYMoUJNwH65EObSNA7cbMmo5gML9?=
 =?us-ascii?Q?RcQoCMON3M/kwnlSDZ9pPLKTnNM7d/6V+57nCm40a/um6b+DkQRqhX9Uj1dt?=
 =?us-ascii?Q?YXcTRZXaKzFR8ONzQnCun+PD0YAiUIXr78Edn35pJLp5iNRsXyf3d6L59hfY?=
 =?us-ascii?Q?Pqcsa67ev/cLo8SmBmEVa/p+CnOJEPNUy/pX+sZRJpg5rnJLY1xPVkEpCwc7?=
 =?us-ascii?Q?MX/BfJyjZX/hhX3H5GA65t4D4SvGmqkSyfYeCU+7tzxTACeIxa8vAtn8ADvz?=
 =?us-ascii?Q?DMrSlt2vKMMmKFc695v8S/VuLdLknK8j7/U3xvIcUKO+InvUYT31wVxDbgp6?=
 =?us-ascii?Q?BsxD8aPl40iK51ppxcUe/QC43FbR0NrzkPrWWnXWM2EAWR/dF+7u4F540nKP?=
 =?us-ascii?Q?t8lS740d+W+hTlvnj3qmP+QIHcMnNBF+lGWHG3K1iclb9+rbHEM+9knCe8l7?=
 =?us-ascii?Q?raaXSV2t7/srss1LBuApMzK1BvAY5OJvCJYQea4fz1J1W/ehlvC3YdFGSiiu?=
 =?us-ascii?Q?AySpdsEOjOZyPbzI3jWpkh+NmARBMf/lLKQ+/hlCUU4uQa+/s1fPgzmCCp1c?=
 =?us-ascii?Q?dorcQfcy9hbSvD2WYrWbLNEiGf4jZveDvuqaEE46sJxNeg0Qc84CDvQ9DTTJ?=
 =?us-ascii?Q?Jpu7rc0Y90C4qJaUFVrRKY13iIxoc77q6f9H6uZV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104686e4-3aa3-44de-2a06-08ddb214f6be
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 05:15:26.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bV1Co/oIJNUfQfEeUVju+qqbWBM5u+gaDRftfVqFGR3eaG+gtd/yJtwNuUmcnVisyhpOOfJoM0aPL+7v1uyZYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559

Hi Henry,

On Mon, Jun 23, 2025 at 12:32:20PM +0800, Henry Huang wrote:
> For some BPF-schedulers, they should do something when
> task is doing migration, such as updating per-cpu map.
> If SCX_OPS_TRACK_MIGRATION is set, runnable/quiescent
> would be called whether task is doing migration or not.
> 
> Signed-off-by: Henry Huang <henry.hj@antgroup.com>

Looks good. One last thing, since we're exposing ENQUEUE_MIGRATING and
DEQUEUE_MIGRATING to BPF, can you introduce some scx enums, similar to what
we're doing with DEQUEUE_SLEEP? Something like the following.

With that you can add my:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

 kernel/sched/ext.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2f0ab232a2786..bf04cde71b34a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -918,8 +918,11 @@ enum scx_enq_flags {
 };
 
 enum scx_deq_flags {
+	/* expose select ENQUEUE_* flags as enums */
+	SCX_ENQ_MIGRATING	= ENQUEUE_MIGRATING,
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
+	SCX_DEQ_MIGRATING	= DEQUEUE_MIGRATING,
 
 	/* high 32bits are SCX specific */
 
@@ -2385,10 +2388,10 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	add_nr_running(rq, 1);
 
 	if (task_on_rq_migrating(p))
-		enq_flags |= ENQUEUE_MIGRATING;
+		enq_flags |= SCX_ENQ_MIGRATING;
 
 	if (SCX_HAS_OP(sch, runnable) &&
-	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(enq_flags & ENQUEUE_MIGRATING)))
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(enq_flags & SCX_ENQ_MIGRATING)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
 
 	if (enq_flags & SCX_ENQ_WAKEUP)
@@ -2471,7 +2474,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	}
 
 	if (task_on_rq_migrating(p))
-		deq_flags |= DEQUEUE_MIGRATING;
+		deq_flags |= SCX_DEQ_MIGRATING;
 
 	ops_dequeue(rq, p, deq_flags);
 
@@ -2493,7 +2496,7 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	}
 
 	if (SCX_HAS_OP(sch, quiescent) &&
-	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(deq_flags & DEQUEUE_MIGRATING)))
+	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(deq_flags & SCX_DEQ_MIGRATING)))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)

> ---
>  kernel/sched/ext.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b498d86..42c5251 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -161,6 +161,12 @@ enum scx_ops_flags {
>  	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
>  
>  	/*
> +	 * If set, runnable/quiescent ops would be called whether the task is
> +	 * doing migration or not.
> +	 */
> +	SCX_OPS_TRACK_MIGRATION		= 1LLU << 7,
> +
> +	/*
>  	 * CPU cgroup support flags
>  	 */
>  	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
> @@ -172,6 +178,7 @@ enum scx_ops_flags {
>  					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
>  					  SCX_OPS_SWITCH_PARTIAL |
>  					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
> +					  SCX_OPS_TRACK_MIGRATION |
>  					  SCX_OPS_HAS_CGROUP_WEIGHT,
>  
>  	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
> @@ -2390,7 +2397,11 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>  	rq->scx.nr_running++;
>  	add_nr_running(rq, 1);
>  
> -	if (SCX_HAS_OP(sch, runnable) && !task_on_rq_migrating(p))
> +	if (task_on_rq_migrating(p))
> +		enq_flags |= ENQUEUE_MIGRATING;
> +
> +	if (SCX_HAS_OP(sch, runnable) &&
> +	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(enq_flags & ENQUEUE_MIGRATING)))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, runnable, rq, p, enq_flags);
>  
>  	if (enq_flags & SCX_ENQ_WAKEUP)
> @@ -2463,6 +2474,9 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  		return true;
>  	}
>  
> +	if (task_on_rq_migrating(p))
> +		deq_flags |= DEQUEUE_MIGRATING;
> +
>  	ops_dequeue(rq, p, deq_flags);
>  
>  	/*
> @@ -2482,7 +2496,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, stopping, rq, p, false);
>  	}
>  
> -	if (SCX_HAS_OP(sch, quiescent) && !task_on_rq_migrating(p))
> +	if (SCX_HAS_OP(sch, quiescent) &&
> +	    ((sch->ops.flags & SCX_OPS_TRACK_MIGRATION) || !(deq_flags & DEQUEUE_MIGRATING)))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, quiescent, rq, p, deq_flags);
>  
>  	if (deq_flags & SCX_DEQ_SLEEP)
> @@ -5495,6 +5510,11 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
>  		return -EINVAL;
>  	}
>  
> +	if ((ops->flags & SCX_OPS_TRACK_MIGRATION) && (!ops->runnable || !ops->quiescent)) {
> +		scx_error(sch, "SCX_OPS_TRACK_MIGRATION requires ops.runnable() and ops.quiescent() to be implemented");
> +		return -EINVAL;
> +	}
> +
>  	if (ops->flags & SCX_OPS_HAS_CGROUP_WEIGHT)
>  		pr_warn("SCX_OPS_HAS_CGROUP_WEIGHT is deprecated and a noop\n");
>  
> -- 
> Henry
> 
