Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0A3845A7
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784609686; cv=fail; b=FsMzJLZLDrAlZ+1ZkpcarpMO6xbvqFewap9eglxxiziB9iCHTk6dvibUps9crTlfRdt8V0fLNZTDDHivBjP7bA7nwZEbZOszmPluyT2/sI4VtQzyv3pLnoNx+ij1hTAcoLlOKFScRTKsVf23ALW7ced8jeQbazd5Z4f6fPf8/uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784609686; c=relaxed/simple;
	bh=Br9Y6DgkxFM7iYdjMSSkVzsE5z5Q9nJPlsPv3+Itp/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rtcbAru9frtaN7hfbE8EzOOJCTThhkNJnT5eLnssKszYZi6cSr2IkFzFkcLFefxwjyTwWuRmqduwtobvnRrREuzDMPy+0k2YqtWbpCzHyhnJzgRbBkcw9BL5kO5Epm3J1QcsKkqKoM9d+0EunnfHGyTMt2eMzbiBgH9WQPQniJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gpD1Qyjx; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gpD1Qyjx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvtfrHyfSz7zKd4SW9HPUExQMioERISM1blQkxoNYVHNwR26RePIP8lKxshC2UQvGRLqYGmuQvo7jf/QWw+w3g4kYSXSrqglrThiY3P/VX82e3OHhbY2yvk6ERaeMY/tlVEgKXstIFUaO+MD3yH7C5VeqX8ILeRzyBKq2Xtv9uLv1B3+V4uwhtWnNeyli2AA0pmY28d2g19YdmC+pwt4Ab8RfNyo5LOMv9fbDljaS3egqs9h2Ye5+Q1xOPmh1pxoaOAjy9ccL0JSEmvvrokEE1OLt7mra+hucCsMiBv0S2XVoqeEsriVAVE9QASm6u3yGZ79h371b2uuk1ow+zihfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36tX/6Ir3pA0FlUBh7RWWZkMfM7bk9OQSBrhufjFBDg=;
 b=QqNztpw7lkpYKfuPiwvZrH3w1tICz29MolyUIR0AdQWzThVw2zRNxTQOBWrJWd0IQfip1ZvM91eLdILPQJdi9JICzpO7l/+ocYW1x+XP0Eq8ufws778T68kPnsMZg5ZxnWLMVJcZa98hRlqBTWvJKmrXSjd6aTQ+biSI2O/1ThnUJ338fFg/GiPlzaczkiDGlStgQBUCEtI/9BbSVEVGU8ZMJiq+jsDLhhdDjxUme6/F254McUgLkC7n4oOPcnt1/k8YiMrKlTzQjUTIT4wzwMaCYZhtG2jdat8q/GNxTwaTGT9d+gfIv2Vb/ru9dSPtrXtRBNKwIdghaYWRGKw8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36tX/6Ir3pA0FlUBh7RWWZkMfM7bk9OQSBrhufjFBDg=;
 b=gpD1Qyjxa5pI7Wmc/UvfByNbHOtwrzeQAP0eMf5YYOAH0isgCe9pfAFmIroViuR1D0yvox+0i/cZH8vkIYhH2pGQV+eNttjFjTmUQt1m1UPmaZ/73GoNek6kLzMzhx3AR8F5YcTPW4dZGMflcZFZZYC3F69ls0VORH6912wsGvolAdIcHccalKFsVib/lEHTv7mvAeKrciAUwjffXq/6wSLGaa1vHdzhPUh4GY3E5x4rOpQrppHf/GK3/VtGBBsT/mLP0sMYivQjm/n7grChzCD+R5z2sfdKfWDafSUYdskvnk6CYjk77U0U2InaK64kUndqnsub6hKqZqOMpeCZBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 04:54:39 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 04:54:38 +0000
Date: Tue, 21 Jul 2026 06:54:28 +0200
From: Andrea Righi <arighi@nvidia.com>
To: John Stultz <jstultz@google.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>, Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] sched_ext: Delegate proxy donor admission to BPF
 schedulers
Message-ID: <al77hBqrJlr1_4Qw@gpd4>
References: <20260716132229.61603-1-arighi@nvidia.com>
 <20260716132229.61603-9-arighi@nvidia.com>
 <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
 <CANDhNCp01g3PN4=hZgCBLUn79_H++y8hyAr4RZP+C3MYckon7g@mail.gmail.com>
 <aluMWf5H936NXA0N@gpd4>
 <al5GZXcH7D0s3I5d@gpd4>
 <CANDhNCrKXY3pTcsK4bSdeMRyUPjzdB+FBwF9A+p-djQ0TxCirw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCrKXY3pTcsK4bSdeMRyUPjzdB+FBwF9A+p-djQ0TxCirw@mail.gmail.com>
X-ClientProxiedBy: MI3PEPF00004EAB.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::44a) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: a24ac9be-9a84-429e-6bba-08dee6e42b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|3023799007|56012099006|5023799004|11063799006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WtPVjXr9rdYX0lHp0C6R/zCzU9Uqq0t82fb30PuFJOnys2F2vEF7Vmeo/1mQ7J1fnamsSmomR0Tn8hmCaNGWKcNRzAh7BgnX4rHg6FBvwxbLTYxXFuFlNjjT/+IpQhdlPxyMu5ao9kyHLNEgK7swN115rc3t7ZGqkEGmzJQSy29D+UZqw+Toknt+NUoteEo8owGqH2NuoClOCfz6d5ZUAWtVwd8kH4EfddMX59htRx27AZC+Sx4SjVWYfrFgN4fTHYiK9Dw3DPvRCGhLrhN2/7GC+Biv/hX9tRhAidqmP7K8kdmr6r2ysroAxcOjrksojnhOSK0n0mvOUNrqfgrYDuZy9N9KGIfzrJT0cA1ezoBsJOCCBHM3BcH7MRAM4GgwJJHwqXM3rPnCqk+mUoc7/6TmASMC1yddqg7h1rY5FoEbRcnv+ksTBWTQLtVlgGhyqAdSjygSpqOlSpEegZlhCdSILZFCIaPeTT3HDBeSBg17IxX9bm0PPcyPrwLxGifcapQHEITH7MEeFXufP/nV45+Ffg0cQ18k7zdnihmqVOvo5GbSlpUUYHyKPVVvjCdNozyOwdscXgkcWY9e+jRvSreiMrtqeTrFn/2zwVkrofVTiu7gZRiIlh5cmZbnK9xQzqcJxIIZBkVQ9uSrm3HKCm688egcvsVCxrVel5sQq+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(3023799007)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nk5uTEhZVlZjRzNxdXF0MGIzaFJ4c2RyYTlkQzVYYW8vTXdlOWZ6Vkl4REtD?=
 =?utf-8?B?ekg3UnViS0FNM0krb21SM3NqcUFTOXo1RkJ0N2hZNzZyNncxeXdSZTBwWTVt?=
 =?utf-8?B?YTNaTVI1d1N4L2UyLzI2M1g2VTBkaTc5a0pJZGt6UzlTUkhYcGhTZndnZVUz?=
 =?utf-8?B?clRpRFdRNFFTYXVWVkhXbmRKMVlOVnNiQ0V5eWhvbXo4TmJmV1gzc3p0cWs4?=
 =?utf-8?B?ZEwrVHBWOXEyd3VBQnRpTUpEV1ZMWXg2OTBQM3BlK3dxby8xMmtnSnEzK0hp?=
 =?utf-8?B?VHpRNjRIVWxCZFUxemt1cmVwYk9iRHJCTlg5bkxzZWZnTGZ4aUIzSWM1eEE1?=
 =?utf-8?B?dUFHZXJSbXAvcUcrRUVraWdIblFXRlVWbXkzbU9pTTJqMVZzdzFkMXNxYTlT?=
 =?utf-8?B?bklreGhXNGJmU1lCSlRXZGdBTDhuWGdKdWhEZGg0cnYyUm5jc0tiQ2d1USs4?=
 =?utf-8?B?V0Vkd21YRGE4NVZvMUp1bWVVRmxSQSswcVAwVlQ3ZGxJZStOT0ltWVROZHFj?=
 =?utf-8?B?Z0lZWk1aSXRqZmpRUTJFK1N5SGd4Rml2VG16NUNHUDA2a1MwaWx6SEc0bHVj?=
 =?utf-8?B?WGM0TXpJazBKY2ptRGl1YkRraS9OTEUvbC9KTVRpSVhSaVZuRkhkZ29SZE1Z?=
 =?utf-8?B?cHdvMHJRWmZ4N1NmcW8xK3NqdkR5aHMyd2RNeUZSQlZhVzk2U2pnUUY3clJR?=
 =?utf-8?B?K2FkTEdVUEZVVHJna0VaR09FdE9xNmxVVzNlSlgwYVptRUQwVERQVW1sc2dI?=
 =?utf-8?B?ZXZ5WmsrbTAxT3V3TTBMR0JtQkZ3d2dvR08rNHRIY2cwYVRNa2V4OGtESURm?=
 =?utf-8?B?TWJvbGF4MlFkZlo3MU56WFBFS2JXcEJDY084aVRZajRoNmMzZW5lcVlVNmtq?=
 =?utf-8?B?ZzhMY0F0S1NqNk53ZXJjYmRGV1lBd3FZVld3bitJdE5kZmJZVzhrVFVJQit3?=
 =?utf-8?B?T25jbi9FbUpaWnZocFVNdDZhYTdpSjhseUxwY25QSGlzeVZKSnlzL2ZmSkpv?=
 =?utf-8?B?aVA4cGhYd2tTVzg5aUpPVDRyUkNpek55RHU2ZXpmMDh6VENuVmc4aDUrOEc4?=
 =?utf-8?B?VlVCbkREc0FxN0VSNHVHWWcrZGwxenluMlI4dEFTbGFLTCt0OWIvTktITmVT?=
 =?utf-8?B?czZ5ZFgrc0NKY3ExaEtGcy9lOTluWEd5Vnh0MFdWMjlqNFBpaUxOMGtDQ2pr?=
 =?utf-8?B?L2FJWWpKN3hzUzVLQnYxNWNWRW9ZbmJadzh0eUhZb2xHVXFlUWtYSE82dWND?=
 =?utf-8?B?TngxM3RmRGg1Mk9Zcmc1OG1QajhJbS81aFdjanFuVWJlcEtJTHphMi9YSE5Q?=
 =?utf-8?B?aXFid3hPVU5IS2lBcUVvbjl1MFp0ZkZPc2k1djNIMGVNTkF4am9HVmxBUkN2?=
 =?utf-8?B?OGxKZWdoWmxEeXd4bjJWb1gwRkYzaUFCZm1Hd3lLZUFKSWNxbmswYkdsbWE0?=
 =?utf-8?B?TTJwRHBGMHhQVGx2dGFLRnVzQkZQeXRBWFFNaWZCRzNuVXZqRGRVVkVBWmE1?=
 =?utf-8?B?ODlHcEZrbUFUUldPMTBldi9ZaDNxazJFTmM0QnAxNDBLNk92dkZjYlRMdDVX?=
 =?utf-8?B?SmcxRE5zUzlZZzlmVjB3WEJGTkIvcDlRdGxaaW4wUHNlNk9KTGUrQW1SRXVP?=
 =?utf-8?B?cjlBVEdWWDVWQTMxYXJuRUpmdFJiUCs5cXdKL2hiZU01M0JVUHhSSWdtQXpO?=
 =?utf-8?B?SVBuazlIWXVJSGo2a2FYUHBqK25HZzdJMVhaV2hJc0hlc2RmZkowMklYOGcw?=
 =?utf-8?B?UUs2a1VsRVFBdXhvRFRGZDMvWUtadE9DNFVZS1dHT1d5OGJSYXp4RHlkcTBC?=
 =?utf-8?B?VE9YcHU5TUIwU29NaWxHK3ljeE1VUHg2QXE4VmZpcTNIa3pqQ3BnZjhkUW1N?=
 =?utf-8?B?RU9naG5mZlZxVllTVm9sYnp2cUZmbTdBTVFDVEJvLytBMXlzWUNEY3JZT0Jw?=
 =?utf-8?B?ejEvSStldWhEUUduRWFUMGlDR2JLSXJhT1cxcFFrMEJoVUJHSC9qM3UySDBo?=
 =?utf-8?B?aVluR1NiVkZsS3h3ZjdQSEhUVUs0bU9kUWFaM0t6RDA4OEpEZjlTcXoxQVkv?=
 =?utf-8?B?dmxaMk4yZEFOaEtzdjE2ZUNKLyttWCszd1ozUHVKblEyUlR1SWVVVDNUajcr?=
 =?utf-8?B?M0Q4c2hvcVZoM3d1N3dsaVBmNWlaMFZMUWNCWTJnVW50Y0RxaWxKMG5QZkdO?=
 =?utf-8?B?cUI5R2xabGU0Y2JjTFNIT2QxSkpVbU5DM0VTZCsvY3J4eWlvcmRkdVo0TVQx?=
 =?utf-8?B?TS83N2kwNzduaUhmUWJhK0VzcUltcTBmcUpDcTc5VjQ2QlgySDFqR250bk81?=
 =?utf-8?B?YytXTk1kd3JoS3dXSENtYXRzeEx3S2FWOUlXRU5qdUljQVpHOGtiQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ac9be-9a84-429e-6bba-08dee6e42b23
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 04:54:38.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nOKoGYcn0Qnqj6VmAVCxx8j9eBf3dIPF0msJMr+e0pyb9kfwOXiCjr0g++VHTcKLRQQASt8fD7yl76DoEbCBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

On Mon, Jul 20, 2026 at 05:37:29PM -0700, John Stultz wrote:
> On Mon, Jul 20, 2026 at 9:02 AM Andrea Righi <arighi@nvidia.com> wrote:
> > On Sat, Jul 18, 2026 at 04:23:40PM +0200, Andrea Righi wrote:
> > > On Fri, Jul 17, 2026 at 11:50:20PM -0700, John Stultz wrote:
> > > > I'll work to prove this out a bit further next week.  I suspect we'll
> > > > need something somewhere between activate_blocked_waiters() ->
> > > > scx_do_enqueue_task() to skip enquing of is_blocked tasks when
> > > > SCX_OPS_ENQ_BLOCKED isn't set.
> > >
> > > Your theory looks correct to me. I was also able to reproduce this. I think the
> > > problem is that scx_prepare_task_sched_change() calls sched_proxy_block_task(),
> > > but the latter has nothing to do when the donor is already off the runqueue
> > > behind a sleeping owner.
> > >
> > > When the owner subsequently wakes, activate_blocked_waiters() unconditionally
> > > reactivates the donor while is_blocked is still set. Since this activation
> > > carries ENQUEUE_WAKEUP, sched_ext treats it as a normal wakeup rather than a
> > > blocked-donor admission. The donor can therefore enter an scx scheduler that
> > > doesn't set SCX_OPS_ENQ_BLOCKED (scx_pair in this case), eventually triggering
> > > the warning in put_prev_task_scx(): unexpected proxy donor without
> > > SCX_OPS_ENQ_BLOCKED set.
> > >
> > > I think we can fix this by checking scx_allow_proxy_exec() in
> > > do_activate_blocked_waiter() before reactivating the donor. If the scx scheduler
> > > doesn't support proxy donors (SCX_OPS_ENQ_BLOCKED not set), the task should
> > > remain blocked and will be activated normally by the mutex wakeup.
> > >
> > > While looking at this, I noticed another issue in the same path:
> > > activate_blocked_waiters() currently passes ENQUEUE_WAKEUP because the generic
> > > scheduling classes need wakeup-style enqueue accounting. However, this is not a
> > > real mutex wakeup, the donor remains blocked and is only being made runnable so
> > > that it can donate its scheduling context.
> > >
> > > As a result, even a scheduler that sets SCX_OPS_ENQ_BLOCKED currently receives
> > > this sleeping-owner activation as SCX_ENQ_WAKEUP rather than SCX_ENQ_BLOCKED.
> > > That's because the existing sched_ext test:
> > >
> > >   p->is_blocked && !(enq_flags & SCX_ENQ_WAKEUP)
> > >
> > > doesn't distinguish a genuine mutex wakeup from this proxy activation.
> > >
> > > Maybe we can address this by adding an internal ENQUEUE_PROXY flag to the
> > > sleeping-owner activation. The generic classes will continue to see
> > > ENQUEUE_WAKEUP, preserving their accounting behavior, while sched_ext will use
> > > ENQUEUE_PROXY to expose the event to BPF as SCX_ENQ_BLOCKED without
> > > SCX_ENQ_WAKEUP. And a genuine mutex wakeup will continue to be reported as
> > > SCX_ENQ_WAKEUP. What do you think?
> >
> > FYI, I've applied your sleeping owner changes + the scx-proxy-exec patch series
> > with the changes mentioned above here:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git scx-proxy-exec-next
> >
> > Everything looks good on my side so far.
> 
> That's awesome! Thank you for your efforts here!  I'll start testing
> and playing around with this branch!
> 
> Though, looking at your patch stack, I'd rather not make my patches
> under review a dependency for your patches.  Peter has not yet put his
> laser-eyes upon my series so there's no telling how much rework they
> may need (and it does have some subtle parts that I'm sure he'll have
> feedback on). So just to allow your current series to be able to move
> foward, would it make sense if I added your "sched: Distinguish proxy
> activations from wakeups" patch to the end of my series?  It looks
> like there's not much interlock on the rest of your changes (though
> I've not carefully reviewed the diff from your scx-proxy-exec branch
> as they are on different bases), so maybe that would just work and the
> rest of your series could move forward?

Sounds like a good plan! It'd be helpful if you could include
"sched: Distinguish proxy activations from wakeups" at the end of your
sleeping-owner series.

I'll move the combined version to scx-proxy-exec-sleeping-owner for testing and
rebase the scx-proxy-exec series without the sleeping-owner changes, so that it
can move forward independently for now.

Thanks!
-Andrea
