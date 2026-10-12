Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717F361961
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796699; cv=pass; b=l+3G2ythuvzp1rlMd+3WoeQYCl1b7QiE668+XU8zZjZrMWPBVvpLzvTWI3erR+h2qeAE1Yd18irWIo/rkaiakfMblALDU7ZRdiPpBxQsxNqARencuCEzrdlRPJmCJg776FMHyTPHC+JEn0+klMyvh5cJD1gVBkce3t9ImOe9VSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796699; c=relaxed/simple;
	bh=Qjk7fnAlrbE4/F3NsAOgm3PV1I2II+ar/lUKWdrB090=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhNUmWuaDa3lhZdQkblQe5VVAGOhYV550i0OB1uq+1g+CH02IYe/xyOrlXb3MaSwdazCjrfZ9we5llCV0XxKaGb/J1qCzJd/EPY3cNjtgKx/dzvZo3NX3q1gmrnL06v3z+NZfpmJwKCX9SvixY5eyVIpqkNdzonFOHI+ZvnNSTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rveOIhFA; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rveOIhFA"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c247f6687dcso258549466b.2
        for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 02:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791796696; cv=none;
        d=google.com; s=arc-20260327;
        b=aVuwOvjibgibOu6T9dmn2s5pc3JDWH+lanfyFOJWUc9+XuSOV2FKKHtUTMMXoKxu+1
         VGiijnWMXOQqGbfEvdoFKdWHr66o/OF560r/MR07Rgy9vFqkBPsVRX9CLoQMX7mggUTZ
         eR7VIH6KtUmR3xm9ePUZmV3Z+PuxWDwz2oEjTDzjuUb71IcaJRk7prPkHIoWuhs8cQgI
         tcWG+95i86sT+9aztc3vC1VpzFk1i62h0CkPC7DF+/f19RPO3Jed3CLmqtVuvOsGhOnN
         f8tuaj+v77CTDHRNWFs1aD0A1NFZQzM/oA+Ep9wm8293n4faHLqqrMNFPm8ILKR4Xr4s
         mBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1biN2HNTY83zhnJs+D3TwuOQxRRYiRudFmWbhPoQzOg=;
        fh=u964TcBHdNg+wc8q6/Z96oaXh2vuh0tzeLTGLCWqagA=;
        b=lk+swh6weKb71oo9tx5v6jYkf4dYEqVzEs1VtPEX2Z1MPHtn2ZkD2RoA42WGdMxDxv
         o53CMtEjzVC2PEFoUM2VHR2VQpTKfF9WEsvmk+FrQr+5e7qAb56Wu1auMK+UlfEu6YLa
         Fy4KAvwQpFo+KR0UV6hBqQLzjrA35R/y7DwWpGBZSAUmhLyIuLa414QuofhrgA5zWOGc
         hPD/Z1wY7DZWAThbjUJAI71QkDbKVSPMzoltzfAypxqf9Ynle7MlNNYAi+nmdG4z8Jzo
         EDElsFfEMX/wB74Q29rT4SGaG3eF2aTEnRtX5QGeMTm9lEV0aPWLRiNeggzpF5YqsMby
         DTHw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791796696; x=1792401496; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1biN2HNTY83zhnJs+D3TwuOQxRRYiRudFmWbhPoQzOg=;
        b=rveOIhFAt+I+J/hkFzeD3s4G4Yhp6PWCWTDKFX4xXJVW9GIQG2bmCZnu62w+liuyMY
         Y2IF0SdstVeBwORm8ljUu+ha/+xpBf/0eG9CBXv/EyYFkWqI/Lvb8myfnfQwEV9jArVh
         POY0KFKnEsnZYdan2++mkBg+nD6AT6JoEoI6n8ijCWD36bdJ13HhDtP2PcfyxkPG66jo
         58GyYT1+xyBsjpJchWvS6tDezQkPPvPVFx3o694WLlGwZX9z1FRc52ykfNQ7EyBhQx5H
         T9KjCqf0XTVBc0AmZpFyv+xS0IRLygGrZyw55NQfZkjzNOnTMN6jTNtfZZSILXGlwuYu
         TnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796696; x=1792401496;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1biN2HNTY83zhnJs+D3TwuOQxRRYiRudFmWbhPoQzOg=;
        b=uy10QX9zNDgA3QcMRA21hCOVK4s3sUPkWX+SblR5rqMGu40RLWC+onGHNJJ2/demyK
         F2LArRPVRiGi5jqRdVhNRuLqlZ/1hjlwCXat7fn5hXsiD6nCZeEmg/aUzpt0l6QoGgVL
         EB4WeCgsIZYZn6534H2IArMQT3QpSEGZvl433lOVn/YkGpiM93Ck4MQQ0StRw2TA1EX2
         Y8KtWTez0jAdxSmD0nnxZOfSuoYfywUm57S+HFpXvlLcmleqW16SJYfS00Ph/G4U5o1N
         eyuvT5Zb6xU9lthGta5VWxKQ+qb8E2+m7HlMWp+mvy/F/iBeoZeKOhLx5kHaOzdBy+/x
         xUqw==
X-Forwarded-Encrypted: i=1; AKwUvBwL0YoPCMHgnZmsU989Ybx3JGVNsvQajE5RUl+d3sEWBpIHjAqfTk+29gHMxcglFdBAsqazcOAdzWQ=@lists.linux.dev
X-Gm-Message-State: AFq9FYLByVe0jVRhOt3EYAB6dQALzjVBZLAIW0x63/f4ZJOVPkPunqpJ
	yCrqddpAMAdet4cVMjJ1X3bejr3Qbo2GE3gtPHfNZ8cBkUlqL5c1iOaFls8cGX6BsZim2GageXp
	05ojZPNKIEDh10l4+4BzwbCuZniEoYPAd2nxyuKSKNA==
X-Gm-Gg: AYBFou1UJvKXeWiu75W0d43nGqiB9wvlMnXMXHp0RcIUAcgz9CCrvgd2kzGXSGmOP0d
	zoz5PK/1eDuM94WrG15Nxk8jr6uHVXOpSILy2RusLQ6np8iA4jKmz9BlnwOC+LepheBrtrVt8WN
	FEFRGu8b1ADPQP2bLdtgf1USbv1WfW3U66LZmGDHiF2fJa9Q7oYInlSv1Gc890Ea7eq0V8W7Odg
	mfnZksgOifOIH3XM47U08JFQ6510QYEUnUq8PvturDPXm2mbRzqYO1g+hAa++KY7I71yMnd+VuZ
	WUfhkNaX2XzotG/Rbyr4bTSMnBFLB5JxJjJVwVVAA0EmZRtinVSP/IWy3pYxDxTlAm0i1cwprdr
	Grryq6A7n5AZ3
X-Received: by 2002:a17:907:c0b:b0:c29:5215:b2d2 with SMTP id
 a640c23a62f3a-c31aa016eb5mr943230966b.23.1791796696105; Mon, 12 Oct 2026
 02:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <asWyZtW7zPVo3k-A@chenyu-dev>
 <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com> <aspc8doovTKdBqPC@chenyu-dev>
In-Reply-To: <aspc8doovTKdBqPC@chenyu-dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 12 Oct 2026 11:18:04 +0200
X-Gm-Features: AclHuK821TZ5FWAZ4M6gg4tQ483l6POneLRhBIaL6kMutdLqFFMPJC-y16mM1as
Message-ID: <CAKfTPtAy-n5_Dj-9x2qxcu=i7eo9DmZ2aaxig_nbyNDbP2m_Mw@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, chen.yu@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Oct 2026 at 17:55, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Fri, Oct 09, 2026 at 04:31:40PM +0200, Vincent Guittot wrote:
> > On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:
>
> [ ... ]
>
> > > @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
> > >         if (select_flags & WF_TTWU)
> > >                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
> > >
> > > +       /*
> > > +        * Only a push triggered by cache aware scheduling will push the
> > > +        * task towards its preferred LLC. Pushes for other reasons, like short
> > > +        * slice task, uses the default push strategy.
> > > +        */
> > > +       push_cpu = -1;
> > > +       if (select_flags & WF_RQ_PUSH)
> > > +               push_cpu = check_pushable_cache_task(prev_cpu, p);
> >
> > Is there any reason that you do'nt want to migrate the task at wakeup too ?
> >
>
> The wakeup path seems to be too fast to aggregate the tasks, so that multiple
> CPUs try to migrate the task to the same LLC without synchronization - a task
> bouncing issue was observed when cache-aware migration was enabled in the wakeup
> path. We can double-check in the latest kernel to see if that is still the case,
> and to see if we can mitigate that.

Yeah, the goal is to use the same select function for all events;
wakeup and push events should be seen as the same event

Also you should separate the check for adding the task in the pushable
list in fair_check_pushable_task from the decision to select pref_cpu
in select_task_rq_fair. The check added in fair_check_pushable_task is
mainly used to decide if it worth going deeper in the decision with
select_task_rq_fair

Vincent

>
> thanks,
> Chenyu
