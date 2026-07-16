Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEF41A566
	for <sched-ext@lists.linux.dev>; Thu, 16 Jul 2026 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201396; cv=none; b=GSlXmPUqxEGO+1BRnvywTpRG5+i7XPB1tL04xzy7m08jChCvvFAlfQzjbg09Dpgq9lHJ1NpnfsWdpcuSNgjzl3OlVYddcARGs4VUFU4edELw+CQycJy2entlzNrzVDSISRhQ5KGllBzJ+8iUY6vRaSm2YYj64Hy0QyOH2GHpmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201396; c=relaxed/simple;
	bh=T/IClUN1T1TR1tLUgekqtYKvQH/vo32RpKJc8+kDSd0=;
	h=Cc:Subject:Content-Type:From:Mime-Version:References:In-Reply-To:
	 Date:Message-Id:To; b=QexwV6tdxGT4VUck4xQPpRTfmHICS8Xn4uC1asvA9l/r5fuiizVdygylau6VmLknCti/Y+5xl6TelMYsLZs3Z/sxGc/BxuyBd6SEpk7b4QBGvP7+/xHb6FW255YuYUcDmQ7EKral8n1g5h6P6BYbifPlzifTJc+Xi485l1vKghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ebZ1eLnC; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ebZ1eLnC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784201379; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=T/IClUN1T1TR1tLUgekqtYKvQH/vo32RpKJc8+kDSd0=;
 b=ebZ1eLnCmy17Tx9iVtHMQzJjTR4a7+b748NGkD03wbdftQhxk4SXiMtUT3pwASjOfuIUxA
 6FZ4PSsPS/Mwr1AmhKg1OP/mB9hh5zhn/61ZMGX56GAYyiG9amThl7pci+FiT1mNIxBqJ2
 l9HgZ61oyHHc5Hz3VWCxrUGeHLxO3qXC+1lATiU7pCBxfbCeYUro9YQve5l/7E4Cvr1FLM
 ZRN/fnQaolwZJvp0o0Pc7sJV3D2sac4eLVVSwflJDSYhMRiWYot98Rez9T95AoGCD+tpB1
 bl57JfJBv0iEtmhhqf4MOutsGOfC6Mt/p56sTF7YQGUXE8zbVvzUv5ibvww4sA==
Cc: "Tejun Heo" <tj@kernel.org>, "David Vernet" <void@manifault.com>, 
	"Changwoo Min" <changwoo@igalia.com>, "Ingo Molnar" <mingo@redhat.com>, 
	"Peter Zijlstra" <peterz@infradead.org>, 
	"Juri Lelli" <juri.lelli@redhat.com>, 
	"Vincent Guittot" <vincent.guittot@linaro.org>, 
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, 
	"Valentin Schneider" <vschneid@redhat.com>, 
	"K Prateek Nayak" <kprateek.nayak@amd.com>, 
	"Emil Tsalapatis" <etsal@meta.com>, 
	"Cheng-Yang Chou" <yphbchou0911@gmail.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, 
	"Chengming Zhou" <zhouchengming@bytedance.com>
Subject: Re: [PATCH sched_ext] sched/ext: Keep tick enabled for finite-slice tasks
Content-Type: text/plain; charset=UTF-8
From: =?utf-8?q?=E5=86=AF=E5=BF=97=E6=95=8F?= <fengzhimin@bytedance.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16a58c0a1+ee783c+lists.linux.dev+fengzhimin@bytedance.com>
References: <20260716023746.3289089-1-fengzhimin@bytedance.com>
	<alhou5r8pMyp-tqU@gpd4>
In-Reply-To: <alhou5r8pMyp-tqU@gpd4>
Date: Thu, 16 Jul 2026 19:29:36 +0800
Message-Id: <8d8f9a8b39ed27a67a8467c38a871adcce9b2873.9e9f7a82.a219.42b3.b2fd.36ae4add8a8e@bytedance.com>
To: "Andrea Righi" <arighi@nvidia.com>
Content-Transfer-Encoding: quoted-printable

Hi=EF=BC=8CAndrea

Thanks for the explanation, I get it now.

> From: "Andrea Righi"<arighi@nvidia.com>
> Date:=C2=A0 Thu, Jul 16, 2026, 13:15
> Subject:=C2=A0 Re: [PATCH sched_ext] sched/ext: Keep tick enabled for fin=
ite-slice tasks
> To: "Zhimin Feng"<fengzhimin@bytedance.com>
> Cc: "Tejun Heo"<tj@kernel.org>, "David Vernet"<void@manifault.com>, "Chan=
gwoo Min"<changwoo@igalia.com>, "Ingo Molnar"<mingo@redhat.com>, "Peter Zij=
lstra"<peterz@infradead.org>, "Juri Lelli"<juri.lelli@redhat.com>, "Vincent=
 Guittot"<vincent.guittot@linaro.org>, "Dietmar Eggemann"<dietmar.eggemann@=
arm.com>, "Steven Rostedt"<rostedt@goodmis.org>, "Ben Segall"<bsegall@googl=
e.com>, "Mel Gorman"<mgorman@suse.de>, "Valentin Schneider"<vschneid@redhat=
.com>, "K Prateek Nayak"<kprateek.nayak@amd.com>, "Emil Tsalapatis"<etsal@m=
eta.com>, "Cheng-Yang Chou"<yphbchou0911@gmail.com>, <sched-ext@lists.linux=
.dev>, <linux-kernel@vger.kernel.org>, "Chengming Zhou"<zhouchengming@byted=
ance.com>
> Hi Zhimin,
>=C2=A0
> On Thu, Jul 16, 2026 at 10:37:46AM +0800, Zhimin Feng wrote:
> > SCX tasks with finite slices need the scheduler tick to make forward
> > progress on slice expiration. However, set_next_task_scx() used to refr=
esh
> > the nohz dependency through sched_update_tick_dependency(), which evalu=
ates
> > sched_can_stop_tick() using rq->curr.
> >=C2=A0
> > When switching from idle, RT, CFS, or another previous task to a
> > finite-slice SCX task on a nohz_full CPU, rq->curr may still point at
> > the previous task while set_next_task_scx() is running. If that previou=
s
> > task allows the tick to stop, the scheduler dependency can remain
> > cleared even though the next SCX task has p->scx.slice !=3D SCX_SLICE_I=
NF.
> >=C2=A0
> > CFS does not hit the same gap for bandwidth-constrained tasks because i=
ts
> > pick path has a next-task based check: sched_fair_update_stop_tick()
> > explicitly sets TICK_DEP_BIT_SCHED when the selected CFS task needs
> > bandwidth accounting on a nohz_full CPU.
> >=C2=A0
> > Add a helper to set the scheduler tick dependency directly and use it f=
rom
> > set_next_task_scx() whenever the next SCX task has a finite slice.
> > This avoids basing the finite-slice decision on the old rq->curr while
> > preserving the existing tickless behavior for SCX_SLICE_INF tasks.
> >=C2=A0
> > Signed-off-by: Zhimin Feng <fengzhimin@bytedance.com>
> > Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>=C2=A0
> This should already be fixed upstream by commit 4ec10f38ff901 ("sched_ext=
:
> Enable tick for finite slices on nohz_full"):
>=C2=A0
> See also:
> https://lore.kernel.org/all/20260708074812.1041434-1-arighi@nvidia.com/
>=C2=A0
> Thanks,
> -Andrea
>=C2=A0
> > ---
> > =C2=A0kernel/sched/ext/ext.c | 21 ++++++++++++++++++---
> > =C2=A0kernel/sched/sched.h =C2=A0 | 11 +++++++++++
> > =C2=A02 files changed, 29 insertions(+), 3 deletions(-)
> >=C2=A0
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 691d53fe0f64..6c0c805d489a 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> > @@ -2950,6 +2950,8 @@ static int balance_one(struct rq *rq, struct task=
_struct *prev)
> > =C2=A0static void set_next_task_scx(struct rq *rq, struct task_struct *=
p, bool first)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scx_sched *sch =3D scx_task_sc=
hed(p);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool can_stop_tick;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool tick_state_changed;
> > =C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p->scx.flags & SCX_TASK_QUEUED) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > @@ -2972,15 +2974,28 @@ static void set_next_task_scx(struct rq *rq, st=
ruct task_struct *p, bool first)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * @p is getting newly scheduled or g=
ot kicked after someone updated its
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * slice. Refresh whether tick can be=
 stopped. See scx_can_stop_tick().
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((p->scx.slice =3D=3D SCX_SLICE_INF) !=
=3D
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(bool)(rq->scx.flags & SCX_R=
Q_CAN_STOP_TICK)) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (p->scx.sli=
ce =3D=3D SCX_SLICE_INF)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0can_stop_tick =3D p->scx.slice =3D=3D SCX_=
SLICE_INF;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0tick_state_changed =3D can_stop_tick !=3D
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(bool)(rq->scx=
.flags & SCX_RQ_CAN_STOP_TICK);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tick_state_changed) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (can_stop_t=
ick)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rq->scx.flags |=3D SCX_RQ_CAN_STOP_TICK;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0rq->scx.flags &=3D ~SCX_RQ_CAN_STOP_TICK;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If @p has a finite slice, it needs the =
scheduler tick to make
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * forward progress on slice expiration. D=
on't rely on
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * sched_update_tick_dependency() here bec=
ause rq->curr may still be
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the previous task while set_next_task_s=
cx() is running.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!can_stop_tick)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sched_set_tick=
_dependency(rq);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (tick_state_changed)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sched_upd=
ate_tick_dependency(rq);
> > =C2=A0
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tick_state_changed) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * For no=
w, let's refresh the load_avgs just when transitioning
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * in and=
 out of nohz. In the future, we might want to add a
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 56acf502ba26..d692d92fc095 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2998,9 +2998,20 @@ static inline void sched_update_tick_dependency(=
struct rq *rq)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tick_nohz=
_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> > =C2=A0}
> > +
> > +static inline void sched_set_tick_dependency(struct rq *rq)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0int cpu =3D cpu_of(rq);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!tick_nohz_full_cpu(cpu))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SC=
HED);
> > +}
> > =C2=A0#else /* !CONFIG_NO_HZ_FULL: */
> > =C2=A0static inline int sched_tick_offload_init(void) { return 0; }
> > =C2=A0static inline void sched_update_tick_dependency(struct rq *rq) { =
}
> > +static inline void sched_set_tick_dependency(struct rq *rq) { }
> > =C2=A0#endif /* !CONFIG_NO_HZ_FULL */
> > =C2=A0
> > =C2=A0static inline void add_nr_running(struct rq *rq, unsigned count)
> > --=C2=A0
> > 2.39.5
>=C2=A0
