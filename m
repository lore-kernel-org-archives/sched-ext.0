Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644DF3AEF2D
	for <sched-ext@lists.linux.dev>; Wed,  4 Feb 2026 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197837; cv=fail; b=T9K68dBb62GfJglN4vnKHycmc4CTDgMN+BXU3moePU9p0ntCppwQ6t2mZuvJd1VHPFsfy4M5Ll3rNkGH5obTOhjxxMc0dzjb79wxD7G1BBGSlgbPH2PaBp6jD5mYImlnzGNQ5DcvWeEwLufgW47H3VdXIoiFU1hcj62IOvW4AkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197837; c=relaxed/simple;
	bh=DN8BR29ZjJdvdrF7rKys37Vi69rGfT5YLLuKchblcdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jVnoibHWjRlStrQ402pRKy9KMNktZ6EYdM/ePQklljQzTrUiIKQbUJeDk0Jkrw7GjUNkTekKiQe5zxRtocc1U9KptmPgDksMtTWvFkRpAKVIYlr1NU6bkybga6mPKmUXpWlFXwyzfLwsnNsRr7KPRPfXyeI0zflJ6QjZKu60Nf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NofpbI0D; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NofpbI0D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRdvSzj+K3Y0vyJKVrOXV7NomjVPsB0ENRrzaPkd0bSpIrlk5Hu/QSqyMSU7foYHcfyHfWLF9dmhtu/xSbrdanH7GO2mI8g+9C/NmhyRXfw8f05E6P1Z0NJ2H4sh1ElaetoBqdlupcowp1ILXxE2xGyFzKw4kW4KcQYwoEBTUk2gXccSA2lrmPkwqv83qTt+u9eaGKXUE4l07zVEM6BPtP8PGRjSbvCUIMej3TFJDpEfT5NJ1+zJhkozS0LVVoECE3A0X5vLsqEjC8qNx2POtyx25BjXGVekGtMH9Cv9skaYq+5+FC3iitW97NrK/rKLG5Pu47tcHct3YeNa8wpoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u79qf5FiMZH/bCIkR03jXIocj5uIHTSx49L297A8i6o=;
 b=qWbIMOlzeLo+OUZ1YeuARmocOxHfFzVtJYRJK3He7BvCTDKiQ0hpHqJH6zeTbh057nXPeXjNQrgsCXV7Gji75WF1NJFrfH3RBiCqmc+42JCMwcTglgZB8+dH8ZBWpmLilnfbpxZfbkuLAeZ7PI2zje0FEyUpr5NFviCI5SykYsJD1qNOJslE0Dvs39UckTzeleAyOd9DbDMDKuUKgzpKkzmP6ZWCXltVLMJgDjaYmZEUiF6KlDaR9RoXuSoTCABjnSe1lwrc1ZD+3j0zC3Ju4SkKXPJfLlqV1DE53qKELYf5oiyYNeQe8IWPn2nBCUr/TZOuKFeAvZkY/8cwg7cykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u79qf5FiMZH/bCIkR03jXIocj5uIHTSx49L297A8i6o=;
 b=NofpbI0DVW5TCAIQifOQ9cs1orM5EUaPJKuLDRMWFCRXpVGc3IV8QkZspSHvbQFdyXJUyrsOkghGrcT3uK9YtR4n8D7vCdU6LrfTi1qX32xgSfVqEowg92b0rKkfd+aD9KcCOJDYwJz8FL6AZtDHhptOrVMCkzLDPPVWBJ/W+IN4yaZdHET7RAHHg1TbHaGuP7ceetvrVzQWOZajYslzVaKfoyq0ttNt9ZYrarRLJ50siro0KFf744HR/9Sq3tc2KlIGtfrV2XX9XXGKhrZXs3VN2KUZ4Ye/SERVHdbIe5vcVWkDsuh5VVEUQolSYaNfVK2wbYvsN/fSTUZMkXMYPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:37:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 09:37:08 +0000
Date: Wed, 4 Feb 2026 10:36:58 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
Message-ID: <aYMTOg8PoMKxK432@gpd4>
References: <20260201091318.178710-1-arighi@nvidia.com>
 <20260201091318.178710-2-arighi@nvidia.com>
 <b868ee48-4545-4b1b-b313-d5863d65608d@arm.com>
 <aYBWAzFDX8Rv-paN@gpd4>
 <DG4J31HM051F.L7TOYLETMY2I@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG4J31HM051F.L7TOYLETMY2I@google.com>
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4b01cf-b27d-47df-1310-08de63d0f6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XOoSdQB56aXxcs+aq0PuS3wefJo62vG/BG6f4vQosD+WU0PN1MLf1onwOCf?=
 =?us-ascii?Q?Ot+CpIV/HcPeMPoW1zphSDaem7U9By3LGUOY8EgmbuOCnKA139i6DFrCgU+6?=
 =?us-ascii?Q?iykqW7+HzSopg7By52QED/yTz4h/ZfprVPFil+LmfUF71ZqdcFrJBhXvfMXq?=
 =?us-ascii?Q?O6dMWp+yU8LhZKxjQgcSwI11eq3TrrZSQpD9QhM415Rsp6HGYU6GXIUMneH9?=
 =?us-ascii?Q?bIlDvjsxNo3Zbn4A7jXpymIhzH3ebJpwxp3VemaovEVq21NKfro7djsbx9UA?=
 =?us-ascii?Q?0UCEn+PyH9UR6kCSvbcctL4SrFP617DKHpPZ9cMEWIpo8CHtimGh4m+oBNoT?=
 =?us-ascii?Q?fDtuQZmsQdNDbX+cV7r2f01fdSIM7yW2gnpKR0L3ZiwdxnY19P5cw8CtnwCa?=
 =?us-ascii?Q?gawA1KIgno6d/DmDk8sBLHwSAO1B7gNC2h/wx9vq1Ok7KM4X2E2ykDhjzGjK?=
 =?us-ascii?Q?57m9sWTQV7IvnvSycAqeJwpqU4MUPV65qGUUMJYWI391prB+uDAv9tyV04O1?=
 =?us-ascii?Q?O73sELOJIhhRD1YLgRNXT265Jq81I5y73E8/NIhP+cN7r9lj2Cri4ixYwx+C?=
 =?us-ascii?Q?Kv6rcZmzFfQKcUcUWNw/wvDHP1Z+homkQ4BMe3gRd6rvh6yNVedx58u+BhMD?=
 =?us-ascii?Q?i8O6VBjPTu0VV2fz5p95U8Nqq6GUHEL+xWAcjmpuyWwH7pavp5Tlq59QWnoh?=
 =?us-ascii?Q?7RTbdF1GOj8lckMuRva83YCHV60KFSSQMnCdm3UYiypV8F/P3Er2tO//06GA?=
 =?us-ascii?Q?ieChQmFL5/oBVRWm2eRdtCxse7q71R5Z1drjLnV15b2RCtE6FB3obOayPNgQ?=
 =?us-ascii?Q?OntmExHnfekzdySS042oJIUNPMtIhxDIz6dsNBgV3oFyFy1sHaYntMgRAtdt?=
 =?us-ascii?Q?zJDYWSwoCNeuB5AP7odeBfL9corFzT2LC/Ss4H0T4K782h2A0JUlIoQ9qgLC?=
 =?us-ascii?Q?7BUhNU3/PnFjPjHborOO53koODgLBQlw+QiioDMiPVqvyt67arZc844bhxEh?=
 =?us-ascii?Q?sAvA/lxQ8jNudJXU8SGJaftDtduhTPD5XvCy2riRuPDbt/KdwLH/frrN5PxZ?=
 =?us-ascii?Q?UUQ9MEnDgwID5jWwcyKIzSqSUUEqFDevGahbhCkxqhqRgpYhw0X4684YtAri?=
 =?us-ascii?Q?uWlmP2cVXxVphIMBAtY8BCeQpPYgoZhEMHlpniRDbPFTs8XG6+2NGouGepeP?=
 =?us-ascii?Q?0oN6OFSus/n0hUzeQo8SRfEhjf+U2QCfnQEMd6qhgUZKi1OVC+PAvOXeG88m?=
 =?us-ascii?Q?Uznzd9peFIBjPrIifrT/KkP1zQIU73W8CRJznl3uls8NJSy9VuZnwuAlAPP5?=
 =?us-ascii?Q?qe2l927+UlWhaYPdNCumKA4Qdug/1rkrzJMJBxpQNoRHXhRGESLUr2bkswIY?=
 =?us-ascii?Q?ZSajcl4nAZySaNDTPG0Mn4xd3Rt1dEdUgd/aOe0WXLJLpdCC2pBqadENoqPd?=
 =?us-ascii?Q?hSqEav7QreOo7tRCk31JOc50k0mTbvSlmpof5ADa/pmiXViYfy7eJMk/bi6S?=
 =?us-ascii?Q?NZcQziFwl8BOIBsMKui0MoryP6fVnopCyjOsYCMz/fBxAozzJqkA6lrRgB/X?=
 =?us-ascii?Q?EhyiUh9CqBFNA9ZqjpQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3NYaJq5CVXBSkMCFPm1o7tGiHJgM7Unopf7YE5m2xV1fuUs+B5WpUOHa53B?=
 =?us-ascii?Q?BSPhETbJXzlK9JO9sJa8oV1Qr2ySM6g4hai6NmPevx9IsNedCXt3eD/OIgFp?=
 =?us-ascii?Q?r9EyNsYnFzZKM2c89hSbeajSLrmojXQMI9WTmS4unvh3k7WeR9CRn9l1XvYn?=
 =?us-ascii?Q?FZQ76FXYehASryQThPVEAlQJHW0Nss3giVY13m+1xBe+rJp65jyjnYA9+z+8?=
 =?us-ascii?Q?P6qMOL5+LAxE/S+ss/NRPEAri6ruRHGuxQJFZyucXFKtGA6gYxO2+d5YAr7a?=
 =?us-ascii?Q?BZm5Q7WKX3u6D+J1XeLz7oFQKeTY52E4PdESihw5I0QFmMYoFuDGEZayyzE8?=
 =?us-ascii?Q?6VtLEYa8pxWhBnmwejR3eJNVBJvCXe9Begli06efdyUcw2SMGyk1x68dfi4S?=
 =?us-ascii?Q?PDhoFtP2IHld0mX3mMIHK0iF/e+iw2Kk+vpzJfsfP5pkVZj8PTstKyB/+0kp?=
 =?us-ascii?Q?0KsbVj/J4HxJQaE/9cEHYZHG6ojH3ZQGB+US6ZGcAGQREKY+Iqom+FM9I6h/?=
 =?us-ascii?Q?j6ie9x1ZTnqjhNu4sqjh8gz7nS9KUAoDbiNOnMQdibVeeDdmIFtG9zqq+2o1?=
 =?us-ascii?Q?ZvqA7qwgE0sD+TbZ6LEU0/yDH1k9zMLUV93xRuOaaF8t6A7QWjwRGVNk96vE?=
 =?us-ascii?Q?nhaNWWJ2C/L5keTJoWwgsAARtE2KXZbVwM8A4K0Ed2XiJcfKPlK90/E5GViH?=
 =?us-ascii?Q?F1A2rOAsQzAvLA3jTgo04vi0jWBClfLdu5E+hXNvGjmeEIME1CrWicwSGlG/?=
 =?us-ascii?Q?EMIaWfdLpsH2syY3D1s0oSqe6zl/Ub1kSDiGhfdAHnOaDiKEvuOitGPXA2ZN?=
 =?us-ascii?Q?bMtN/Y/HSwa3juqPPaoi35XNmhFU1zEpStMlSkadNQsymj8e5Inwxflx6TtW?=
 =?us-ascii?Q?AltGCEhaWcjmTvlnGOpZ+HZhZ1AOvBiW0Ynwt0zXhdNrMmyGJc/BgVfkiWp1?=
 =?us-ascii?Q?M/by22qepm48iV63VwLO6es9idlx/jcr7yY3hFHbrsfStJkO1+h5bLt9737B?=
 =?us-ascii?Q?HhzQynRK/fpm3nLcDjP5F8T1ECCFMWv69KkNcRF+tt+NvTMw0Y/mq7J1ZZw+?=
 =?us-ascii?Q?WfBc03GF+hLMk7qPZ/F6ZZjNhGoplXSNMRK42et2w7n8i8VIyFVrYIW7GEGA?=
 =?us-ascii?Q?vTTmohgOBVb9TK2LLZKthhT+Cy3Hi9ZTzHQvrgFXrqc6GO4PxBmlPlgCT8it?=
 =?us-ascii?Q?7p/r77vLMI1E1Cvz+u2lSwOaR1HV0uww5E9LVve3N+83N1KwAoOKCuAfqQAj?=
 =?us-ascii?Q?0y38N/vYLo7XkYNK1AqLzFvCGKFbadTBHr1RuK3E6Ul7KWIqIXUh/BUhPtBC?=
 =?us-ascii?Q?pEqs5ZY8N3ztH62cCNiyk5BPCOUVaz1NVIBcZLGlywfbc9xR5R1zmHjgP17T?=
 =?us-ascii?Q?LSs9bfcLvG4wZqXEjik5JMzcmrS6N3FzssC5vb9RXLSjm/SWxqDqUE8CrRug?=
 =?us-ascii?Q?xHt3l+dmK+Z8HvLLTwXi6YdgL4rebcSQ3GjtIHoZcTzFqCI9UqettxNhyBHV?=
 =?us-ascii?Q?dbdLlL6bApD0kn1mlU2Go0llX/SF9gTPoLJAlG9YKP/XTu42XWExMyXcZIA3?=
 =?us-ascii?Q?spNsH9+sY5PhxmDPul2dCu9bf7UOyql6FqFDQIvbXOlvQPUPy7CilvwjVEXW?=
 =?us-ascii?Q?k28uT0Dy8/tB6R6+jkeSkJrMA5G49Sq3/xf3kUA219+txoVtuknfytcJtPsQ?=
 =?us-ascii?Q?y+jDlkgl+9PISK/kffITdgeJzJLDOB/w2t0D1QGrS7l6N265HlBHXM+GQEL2?=
 =?us-ascii?Q?PZn3+4tKaw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4b01cf-b27d-47df-1310-08de63d0f6dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:37:08.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JQrEbaEXhzsXuYF3oVSw/jUptV5QTnvQeIdAsshcDiU5/W4qiXCpP/gYNPdHBMncd1Y57QBlwEmo+oKBTiV/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

Hi Kuba,

sorry for the late response.

On Mon, Feb 02, 2026 at 01:59:24PM +0000, Kuba Piecuch wrote:
> Hi Andrea,
> 
> On Mon Feb 2, 2026 at 7:45 AM UTC, Andrea Righi wrote:
> > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > index 6d6f1253039d8..d8fed4a49195d 100644
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -2248,7 +2248,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
> >  			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
> >  		} else {
> >  			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
> > -				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, task_rq(p), p, 0);
> > +				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
> >  
> >  			p->scx.flags &= ~SCX_TASK_OPS_ENQUEUED;
> >  		}
> 
> This looks risky from a locking perspective. Are we relying on
> SCX_OPSS_DISPATCHING to protect against racing dequeues? If so, it might
> be worth calling out in a comment.

You're right, we're relying on SCX_OPSS_DISPATCHING to protect against
racing dequeues and this definitely deserves a comment. How about something
like the following?

Thanks,
-Andrea

---
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 292adf10fee1b..b189339e74101 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2260,6 +2260,15 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 		if (!is_terminal_dsq(dsq_id)) {
 			p->scx.flags |= SCX_TASK_OPS_ENQUEUED;
 		} else {
+			/*
+			 * Locking: we're holding the @rq lock (the
+			 * dispatch CPU's rq), but not necessarily
+			 * task_rq(p), since @p may be from a remote CPU.
+			 *
+			 * This is safe because SCX_OPSS_DISPATCHING state
+			 * prevents racing dequeues, any concurrent
+			 * ops_dequeue() will wait for this state to clear.
+			 */
 			if (p->scx.flags & SCX_TASK_OPS_ENQUEUED)
 				SCX_CALL_OP_TASK(sch, SCX_KF_REST, dequeue, rq, p, 0);
 
