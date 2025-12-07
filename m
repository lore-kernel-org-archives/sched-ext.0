Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1D18E02A
	for <sched-ext@lists.linux.dev>; Sun,  7 Dec 2025 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765098769; cv=fail; b=huSSHIpRV5MzDmvV0Ogpsl5vgMhJ0/XhcfovTDi24kDw9j07w/65YbHW8kz7m1+NtRdvzg0h9Zp6NCg8MhuXnHnfRqNt1J+Ds+G91Og+k9jN87cDB+KARt/+wcaYnWVk/vdoKvAid0y7fhrvR/ZnD72+mRkq9LG3shaYoTT6Ir0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765098769; c=relaxed/simple;
	bh=ztqErDui9I4hRg4u4mNBugEHi5N3bhMcV0tqM7tTtpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f7mRvWs3vRV/yw+zJeoOmCiWTzbJ60rmSHP8myBjATyJswDf7KC5AO0Bs8TNspwsrVPIBA0NGAmNgix78Y9tBpA2/teb+K1mvUtoMCP20MzJZh4R4VGHl295rGgG5LmL7nBXWTR2c3Raz4ONkmeuhkjeUV6BEFeaBqtqXblypGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=faOyL7uI; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="faOyL7uI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV2WH7jqVSH4LtIlOXWabLRuwG7db2HnUyDjJOhzt0ptpHCuicX6ag4nS6DTBTdEJfC9rUhI/L63A+IplVp3zAKhyKovDXTxeHLbg3nvs4e1usi+rY3gm3Jyo5ig5pelif2QJcWtyuWCPiWmSGgUdbXEAVNH2NqSmd1HL+aqciuO+05zOYCidBgEdD7WKVJ3cqGCAm7x3ZmRvfNG0arAKkOCC1gjk1CCSlRg174f9AKJl8d2wYTbsPBOaPoS5U3iEgB3WDay5pa1GzxI93Ia2cvd1bBwcdN3OsqMWtdiG12aH+DgB7hLCr25fFuvFB9dKsQu+kFkG5sK5uExVALuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrv/P+pUPtDwtjduRSzPAwhuf1gr7DSHb3kWdOMfhew=;
 b=bcx6890dDRZzxidz/Awczoua2PTe+dwlN1K5KSaZjgog3bzX/pzwikSvkonkzXj/JWgU4Zqqc47KBizFDAXUHVDqEMlJ4DFQch7zTQcfpXqy65HHbY4xs9WHHc20X8KDUwFAUz231Q6DX2oVPDQhhv4IgmRYEj8t1b+libCRHWFSozh2wD9oClvHjtUd5BuzMukBA7WzIg8+xseCNA39yfmdIKe1oPoDz7GYVztDwE1RJLhIgNKGiuYj5nfN2HjOl3MpOv3lITCAbkKrPWOlLnVQiqULEXHwgsyxiFoFgT3K6dVBehTfspk5A0QFh6lx9+D8Psna9deKDSv+izfbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrv/P+pUPtDwtjduRSzPAwhuf1gr7DSHb3kWdOMfhew=;
 b=faOyL7uIfSI5p8GdvqbuSit/AsP9El7NsdRSGPeXf2Tf0O64/iARVdT+SzwmwA73AhAVHinpK05f1xvINIG5htLWe6a5zXiWeLI43u5I+Hikne9j4lNnvnXCKWLNlT2ftwKf3ZH0Jol7LdB3cQW5F1X/u5cu524p/bd86R+XoOjpG+kf6kdtqBqYF8u+8sh0sBM5Kx1sYMvZaJTc7siOhrAKge1LJUyULjBzPrXPSuAymLL/hBJk+0sMLoeEPIh1oWVgkHYpN2U9PITXFb9K0msro3/3HzmJLui6n6j0xTXV2GZJPrqMLjR/gv80lKyD0j5RtBVSKjRuCQxNtNU8XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sun, 7 Dec
 2025 09:12:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9388.013; Sun, 7 Dec 2025
 09:12:42 +0000
Date: Sun, 7 Dec 2025 10:12:39 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/ext: Split curr|donor references properly
Message-ID: <aTVFBwzJGO0hr_c2@gpd4>
References: <20251206001451.1418225-1-jstultz@google.com>
 <20251206024724.GA71744@joelbox2>
 <aTVAxCUVyBtv3hVh@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTVAxCUVyBtv3hVh@gpd4>
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: af1cfa1e-beb3-4cac-3385-08de3570c708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJlTpcvX29EnvyNGzTTV0Hj+vvwxB1ZQnEJD7VxRHqZ68LqF5qRjBt0g1vUc?=
 =?us-ascii?Q?94MQsCDUpvwiMGF1KhX/9MaFbmqKNmLna8AQ95IYcNyZ/uI5D16MUFvlQya+?=
 =?us-ascii?Q?NHdykPeI4HESO0IqgLBKfmuUnCzpdRmiSk0q2t/6A64dBORbmATZN8v4hWBV?=
 =?us-ascii?Q?QR4NGmWTQvnofufydoRDScqvK3X8fPC+BOhA9ZkLU2ah/GJG6xMxz/Gwa1nu?=
 =?us-ascii?Q?kEqgb47iNZxWhQwjmIsk4pzWQYSfcRSww6sH7Rjupers2q4ZrzAtnf8ZVXcx?=
 =?us-ascii?Q?7BZiapUZmpSPEjiqhYuLASU4UYM+GiaoQBaTQeTkYHb6FqxjrVsdYGZzZcIP?=
 =?us-ascii?Q?pCvhKMveQVkVL8tusywe3ngQONsYqA3UW1aDUMZnBoXV1kR85y1zkIhr6IYe?=
 =?us-ascii?Q?AGxdmoJr0ZDzOn7uKL5EpQmiLCS1jKRnnYJWiIvce9pGfHIXxWLSEdLlobOa?=
 =?us-ascii?Q?XLrh2SeTCwH/MM8SfMfanmiiCfLHuT7v+SvyE6e9H/UIb2zJu75fkzum58i8?=
 =?us-ascii?Q?4vDnTIM36uPg7R15h+pSnmZusTyh9zeEWS81vCRGH0UAUl5daKKJryxdN6sX?=
 =?us-ascii?Q?h2k9MeR5ZzuDBnBeSkUzj+mSp9yYluDz6xK2uw0nF6d2BMEdDrY4qCAi+qCV?=
 =?us-ascii?Q?ozMUF3Y+H89dXXtAxVZ7ubUXux8cJEFygFZUZjSfTDccZylFEoqA1QOe6HK1?=
 =?us-ascii?Q?x9p4JgWR4F5N7jw+51NNNi82i0N1HkNrlwzHDfytHhVPGShwQslZXWUGzZBT?=
 =?us-ascii?Q?CI17DdFUewbX71x3VYzNr+f7hDZ/T6471wlIpHs4/jjeEzObfFGwdq6vl7us?=
 =?us-ascii?Q?cY+75qPbG5m3UVdBjvbvEBa1bRIiNE8I380mxlYsMfq9fofOD3TnKCgC2o8X?=
 =?us-ascii?Q?1qP5lcfAQIn8L05oUY3LyJ+weG+79JISAqc6Bb5v701Ik5aTS2xhU4uYFugs?=
 =?us-ascii?Q?8Zz6mYHBVmG7CVbLK2TPnbVQ36Gen2xpEgT+qaS8DmaCYJdZ3oNg8mrQjBqS?=
 =?us-ascii?Q?MpjnZccRGlw/XWvLwr/AX1luVTiDRimyMZsP81b1sPcD/D/OdPZJ7Ddnt+yv?=
 =?us-ascii?Q?/4uS/S6nSlYTFIPYOk+ejbstF2qLEbZg7OVjJZq9VTBNsG3gDi86TWbXeO3K?=
 =?us-ascii?Q?6Lhmtw/gRmjOhIkG+IyMk3e9R8TSTZFdK85MxHTbuek78/VylxNl/h8CTBQZ?=
 =?us-ascii?Q?6IKWSbW3jIFzlypIhd+tsNbzHTokVN8T1scoO6g5BSePQhhSIeu8too3Wq4f?=
 =?us-ascii?Q?akwHFvQwzfWR3HTFdRSFK+9AAjGuDKcPEV2izqqJNXY+Kdc/gZc/T4sEDSdP?=
 =?us-ascii?Q?8X5U8vtKC4A3LjIb3p+9/lRJ69P8wjCj80WrZj3EgeBi5fDWl28n+D95RxFA?=
 =?us-ascii?Q?S3VXg3SgQgrrlql9Y2VqgbIFBhWgYenhrN5QygTV/gTEvgx4euVYKlJY8w1w?=
 =?us-ascii?Q?IcTgvI7dC90zY83Y3dcEpiRPgWHqQQ/9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYbKQr71XapCBfv+MpUGQknow8nYPXDWhrg/QXoA3aD2o4LhqrtckOuJuXeL?=
 =?us-ascii?Q?5dVDMImrPYkXnuHHk+D70KER7NcMUTCj8U0AwOYqm3goXWUufcbitp/Z+Ns+?=
 =?us-ascii?Q?vc/4rf/kHFWSqBVDJhzEz07XszJhysBLzaK3ihg/+eDU1Tdumo45F98srluY?=
 =?us-ascii?Q?txfbkF6//S9axI7HRNZ/8jRCj8hCuxUPcbr2N9v9/CYBQtV6KmBVkn3miouB?=
 =?us-ascii?Q?0Dwde/FPtQoWF7JmPcnUGVLQcJqZPjN7bjyz+EHFSYC9jsMpoEcxdlb9bLca?=
 =?us-ascii?Q?cgAntOVOhusqFqN/iG9DUjXVHEFCmqBTXivGnXQ4A2Rv/+nz4lN2p4fLQTSp?=
 =?us-ascii?Q?4dAv1gWU5aUkZHxRNmiRlWRpvcDyoQYbpg9Kj+1sAJ5eHFsWjOzIKZ8EalKJ?=
 =?us-ascii?Q?pOaduaFqW/rQe9qBdXJ9Xi5SB6ZPy3XzJAS6CvN8ZkmtQnct/aIGVovkIaXq?=
 =?us-ascii?Q?MjGdenMPT2P2BIj0P5sxrazHaOsXS7LhHUxNHBpvhezeGBDbxncytWB2FykW?=
 =?us-ascii?Q?EVT5KFL/4ttPFm0WewP+TmdzKWFXFZvNE5zg1xmV/Ci5V7mGpYSgeSlQmLmA?=
 =?us-ascii?Q?2HAWEn15QYOWv7H/BUPrZftBq+g8n+BiMsZR3WqF78Be/WTZZKkyAcbStsZ2?=
 =?us-ascii?Q?tdVgh4qjNqRzQFKZvW4B4WTbFgL2IaPfTH2c143eG/3uuFnWsbecBF3RCng5?=
 =?us-ascii?Q?41Uy7jCGwMAb+fcmWR85zqFjOO+H1OxWSla0uHyD+Swg5tjoHfWn0kvNLuyc?=
 =?us-ascii?Q?h+giw+InEc29ck7J55mXJjerAKZ94l98i2BuhUezyWDD6znwiDvB82/Af8A1?=
 =?us-ascii?Q?mrQHNbdSkYIyxTkgkDfp2AYFAU8WdZRMGv4hBy81znyvJnZ1EtutHACByTvd?=
 =?us-ascii?Q?UpdNSs18JIj/gWKCG/6c8CO7B/jS0J4wGg+yvvBW0m0ty179kYR00QMB3H7S?=
 =?us-ascii?Q?koYC+s+gIoUwBEAjDafrmUBZa7SRbgnQnelC6JAI5Utch/Slcgb6v8MeNv5c?=
 =?us-ascii?Q?TZ93cK1b1mCYn5FvG5VJ06jACrSBpjnOUnkiE4FKsgGb0mZs7V4LTJwVhKLC?=
 =?us-ascii?Q?7Gy2l7byuSHgiSuQpEfiyp/kN0mFZej3Sz4ErgEw1vwGOf8lie1qN5VRY2Vs?=
 =?us-ascii?Q?pI3deadKPs/e2cO4X9eZdzY81m87jIQ3FlhWzrVqoaD2MZ1y4w7FZ3U3S3Dg?=
 =?us-ascii?Q?B8QXkuSMAa1n0Rwdwaqx7c/7iG0UQXIDFBgWoFHdgThNzJmMn280eu6t2CRW?=
 =?us-ascii?Q?0UAROpc2Oxml38SzdFcKW8FcqwuLlESxwEmyasTOr4/VQnhR6NvhzdYLQQJf?=
 =?us-ascii?Q?B7GFoITgcaH4tjnCMn1YMvt0l8T7f0odfd1HevrOhdkD3tDRd/gJcLiSIzX4?=
 =?us-ascii?Q?dhg8p0l40NF9XR8lumxMm/g6k0YJmvwzMoMV4szEk3w5qhYoSxvRXNGz+dtc?=
 =?us-ascii?Q?XHR6jQ1+01Jw8uTu95XVWnROUJAH8Dl/hmz4VBXuT8IODSWozczelxDYR1eu?=
 =?us-ascii?Q?PO3qLxjHxXtcxTImtMsNXw+mzhMPHqjaACEfu3+o6rNbb/Ifw0cShXWoJWI6?=
 =?us-ascii?Q?uKX87rwlhB3QYuQ88SfPK/RkoqzwKaKbDLRFnz8u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1cfa1e-beb3-4cac-3385-08de3570c708
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 09:12:42.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJgNm9V+tANmaNl3HeqRPNIahexdLD/QJdiH4IqRVRRg9p/iamwOhpAyRWpCmZ4P5K+XMbzfdJCTCe32eMsCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479

On Sun, Dec 07, 2025 at 09:54:32AM +0100, Andrea Righi wrote:
> On Fri, Dec 05, 2025 at 09:47:24PM -0500, Joel Fernandes wrote:
> > On Sat, Dec 06, 2025 at 12:14:45AM +0000, John Stultz wrote:
> > > With proxy-exec, we want to do the accounting against the donor
> > > most of the time. Without proxy-exec, there should be no
> > > difference as the rq->donor and rq->curr are the same.
> > > 
> > > So rework the logic to reference the rq->donor where appropriate.
> > > 
> > > Also add donor info to scx_dump_state()
> > > 
> > > Since CONFIG_SCHED_PROXY_EXEC currently depends on
> > > !CONFIG_SCHED_CLASS_EXT, this should have no effect
> > > (other then the extra donor output in scx_dump_state),
> > > but this is one step needed to eventually remove that
> > > constraint for proxy-exec.
> > > 
> > > Just wanted to send this out for early review prior to LPC.
> > > 
> > > Feedback or thoughts would be greatly appreciated!
> > 
> > Hi John,
> > 
> > I'm wondering if this will work well for BPF tasks because my understanding
> > is that some scheduler BPF programs also monitor runtime statistics. If they are unaware of proxy execution, how will it work?
> 
> Right, some schedulers are relying on p->scx.slice to evaluate task
> runtime. It'd be nice for the BPF schedulers to be aware of the donor.
> 
> > 
> > I don't see any code in the patch that passes the donor information to the
> > BPF ops, for instance. I would really like the SCX folks to chime in before
> > we can move this patch forward. Thanks for marking it as an RFC.
> > 
> > We need to get a handle on how a scheduler BPF program will pass information
> > about the donor to the currently executing task. If we can make this happen
> > transparently, that's ideal. Otherwise, we may have to pass both the donor
> > task and the currently executing task to the BPF ops.
> 
> That's what I was thinking, callbacks like ops.running(), ops.tick() and
> ops.stopping() should probably have a struct task_struct *donor argument in
> addition to struct task_struct *p. Then the BPF scheduler can decide how to
> use the donor information (this would address also the runtime evaluation).

Or, better, have a kfunc like the following (I'm just sketching it, this is
likely broken):

__bpf_kfunc struct task_struct *scx_bpf_task_donor(const struct task_struct *p)
{
	struct task_struct *curr, *donor;
	struct rq *rq;

#ifndef CONFIG_SCHED_PROXY_EXEC
	return (struct task_struct *)p;
#endif

	rq = task_rq(p);
	curr = READ_ONCE(rq->curr);
	donor = READ_ONCE(rq->donor);

	/*
	 * If @p is currently executing, return the donor.
	 *
	 * The donor can be:
	 * - same as curr (no proxy execution active)
	 * - different from curr (proxy execution: curr is running with
	 *   donor's context)
	 */
	if (curr == p)
		return donor;

	/*
	 * If @p is not currently executing (queued, sleeping, etc.),
	 * the concept of donor doesn't apply, return @p itself.
	 */
	return (struct task_struct *)p;
}

And then let the BPF scheduler decide how to use this information (while
still updating time slice and check sched_class accordingly, as John is
proposing).

-Andrea
