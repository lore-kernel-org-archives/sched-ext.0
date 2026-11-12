Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794466891;
	b=ECuz3mZPWsmy/Hcxv7IQSREVuane+MFwUhTUYk2p28VCEKExYNnqVHXQ6Oc7NIxe0qKg
	 wQwjLUt6010Hjqiw8CuqF4NtS78GOezUMry36K2pfKesBqoMdfkxtdOLg0QP4jqJBtYFo
	 pa0FtIbx4ksOBWvnA1u/g9gorfKu36VRBp5JIHqtIgqfnQMdQ63HykoO573Qj3D0jLLHJ
	 xAAsd78PuiKNtZnJrUwfb21sud5luYIY1fTVnxXlBLt99Sd+Io3wvKjl0r8Eo5+Gf4rYA
	 mvkXD9+jujUtjlhCpvv8s+ZJpnqiqe73auAFOQ7NvK/5wAjCl5YvG54Fsjl5xgHN+BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
	b=r8t7j3Igj91UQXKM7yqxU4g5krP8H74qiYnWkg5tz1ne8ic6idFuF8+eYYp9LKwj6xnJ
	 QfTtbrOJoX92eHBwYsS1hc9GRbuXlmxN6y6AYnKef9BU6Wwhle38N44eF8Usa6fTn0U3N
	 bpnUJ7Jio/lHv/OcVh74TMEw9WnOizFzV5QYnk1NtpV2Q4osg/NAZJ7I6u1pBLZ0qlXBJ
	 BD/pLo2nIHcG3f92skVw1lG90osCeQB0tWsDWsKEffs0SsyNk6Sk8mp+H+nAaluGMY+h4
	 89sJ8HKvp+qB/L4uTvreP+iC4QQszfHOAi7Gyt1+yWRyZjTgdtrkEQNTd3SoCPY/JWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YhYu+19P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51992606A32D
	for <sched-ext@lists.linux.dev>; Thu, 12 Nov 2026 07:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51992606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YhYu+19P
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so830654a12.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Nov 2026 23:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794466889; cv=none;
        d=google.com; s=arc-20260327;
        b=HlITyEslCHa/rY9svx3Qfxrki3TT3jJ2PnVJXPrSrH4VX1i2jCUeRaAOkZhSjMCqAi
         8tLpwSL+fIyCF0CaOOZjaXPplEGBQ2D9JjIaDu6O+KUEAwva9wteVCekIWSo5Za5Mmle
         xSQP9EhqPKAbz4l1Qag5CMQrm9Tjkp2pSkfstRf43t+5mkN/mO0/WbUT/5LUZn+lMAGB
         RZ+2mcUa1UKtDU6HpiZiS04FgVESaT4uow6EslvsXugpMl5YXkaokbirfHfZvAhmIrts
         DET13fLAUHnsTSgvJyE9zQUyPLGU/5WlVHPjM/0x/2Z1HYBf3DsbsEoKLUhgCTGu3kLA
         StIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
        fh=30fEqjfD9Pextk27g9w1LM4akuY/Aza/ddyGRz138nI=;
        b=QMXu3lCcYzm8H9scSZKfoE7n+ErSQPrpS9wjqRIjviLoCBSae/+T/ADspWpltL9Elf
         DADAws7piVVbmFkS9oj5U5Kl17qukfP5xARv83m1oy3CmPgl1YByJFg1wU4Lb2HIv0dj
         CqAd2FQvuSa8MN9ZEvEGpbimFj1oHRsQlKWBLAK1tX3nHKF/zBU9jUIDk1uqeSP5unV/
         rYahR7v3Kc5H3oc35R6bf4B4ceT3OaSw/AE75HHLBAe+qBgvAyfxmGnqnesFKkGTdr8C
         wdj/19obecxEs2iNsdOngH9jLLnXunzNHqb/N5sEuigJzCKjotCfOxIzTW6l8/tAlpIz
         BDfg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794466889; x=1795071689; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
        b=YhYu+19P6rrjQkPsX+GF2zeTZVQY6fqZZ+W1DGZOSLs2nCyAQMauc2CTTt3chcvIDJ
         7iULOATPB/DPmLArUMw476MJVCWfbHhsWWxh+g/YW+1D+6RBZRGnyv8MNa6gAxy16M7U
         UUfBPwPltKIFvdiGVvdbqDbGPXK4z+gBHUAQ6XAjkCtu5DO8f2nIn1COw7UwLb3XR56A
         xjiIbkPioNeZQew7aAUsmyNw3jQAXEvY8XBpVywRjEYYYZkawxb6B19jHF6EQIFVM7W3
         AOLwq3XxstDOT/jQhIjYGH3WPW29cwZd9/+QTyagCj8giiS5DfUfoystpDjCqWA/Xaoj
         c3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466889; x=1795071689;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MSgj+o0QjwP2h00l2eEN+Ttef4mTAsT4O3zROWvRIfE=;
        b=yGSgbeeJ931/f7IOq040LuL2bv94FBloMVnI6ZGMzfZ34/dHYDSMgLI42X2SnmS+Ya
         1UGPXueYfaJ5xrocQ5R6xWUQLLzOi84BOh/fBoksXGbGJqmyhBvL8ZQQOyZ3Pe31k4AL
         RKQeMVxPOF2lKzO/LYfh6mymtYJ8ky07eo4LnaIRAedE5nh4CCsXRbOg47nD01KYZetg
         N7+MeRedOK7UlyKdwKV2ggl6EJgFkLw8DdLf+M5EHfmrQzPQQ86sV/EYfTFso/czjCjP
         cbH7Cec4me0minpwVbaoJ/0VNU6z0SfG4Q2FYjX0Laa+JeU3fwW3in/DWyfNOHB4unAZ
         uhzw==
X-Forwarded-Encrypted: i=1; AL+hErELDg2ipLkl7w+JiMkieR1j0bCvIZSZCoUgJem4E4FOm6ldADFIXZKjnf6UDZm3JBB5mbZfXCeIWxg=@lists.linux.dev
X-Gm-Message-State: APuU4Z/TIz4JtXsMlpcu0ELbRBm1AIm1C2l24uabU5HsDkAjq/Sxyu5m
	9eghTZdkhlAj7dhvMyOccIwAvExAISFVviLk2Ch03KV4+54TL2snCP17Kd9eHuVUnI3gWLWUWcw
	ukozXnVPEJ+EDHP/42g+EMK0v3VpWUizrsjq8UWKVtg==
X-Gm-Gg: AYBFou0t8CooEubQhUwcqT7CcLskg1B2huur2w179zyaHZKV/j0S/RSLqQrO766f11m
	9ZmCNyckpMB3DSXbJ0sX1uIMWlV/l3TuBKtdVVWnfdx+b8SKgsAaf3x0vx3wUOAbJWBtsc0v1Xm
	THNq/DhepE7ElB/i7s1b2XTdEDNV6H6Q/fey2f5vCxgyLRiqdoh+mixKiA1rd0zuQAxaUdA6uvy
	WNCEjuhtOGNTzGTR8LrCsTJmC6JEeZREdcw4Nd2vh0a8sCg2isX0pTopnn8EF4Fiq8QQVDD+NgE
	61NviR6VMGgVNJIfmu3JT/22r94Ru0GVMH7dUj9nHQeD8tUZUFOObsN48dOxDsd2/vk1esZ4jEg
	V74ATQ9ury5K5tBHqn8i/88eKBRu1IoehzYpwgJ+QyjxrRbNHQQfsfKCK3R2E/42o09Ct8fCja3
	0KxGg9/dwihgISUMs=
X-Received: by 2002:aa7:c606:0:b0:6b5:94d9:10f8 with SMTP id
 4fb4d7f45d1cf-6b7773f5a18mr2509828a12.21.1794466889315; Wed, 11 Nov 2026
 23:01:29 -0800 (PST)
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-9-vincent.guittot@linaro.org> <20261109155418.GL1779021@noisy.programming.kicks-ass.net>
 <CAKfTPtA-nrgGQGcBPqNoPk4atOHakyZK9Fk-4AsrHBrnvPXTLQ@mail.gmail.com> <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
In-Reply-To: <20261111090155.GF2668564@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 08:01:17 +0100
X-Gm-Features: AclHuK8UVt3x6vMPLZS8pSfeYTsVIPRoQvrz41V51tB_Ja3VDFaTVes1TsX82JE
Message-ID: <CAKfTPtBfQd5nD9jNdayGbEW_P2bDMvOm=GZ3Q-gu+O6KkQmKbA@mail.gmail.com>
Subject: Re: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, lukasz.luba@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, kayracizmeci@gmail.com, 
	tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 10:02, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 09, 2026 at 05:14:39PM +0100, Vincent Guittot wrote:
> > On Mon, 9 Nov 2026 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Can't we add the 'p->nr_cpus_allowed > 1' condition to rq->cfs_tasks and
> > > use that, rather than adding yet another list? I mean, its used for
> > > migration, so excluding all pinned tasks actually makes sense.
> >
> > rq->cfs_tasks can be quite large (we even take a breath during LB)
> > whereas this list should be 1 task most of the time (except during
> > wakeup)
>
> Like in the other email; detach_one_task() is also just one task :-)

but in some case I want to do more than one like the case described in patch 20

>
> > > Also, I'm still not sure why we need a plist. The rq->cfs_tasks list is
> > > MRU per set_next_task_fair() moving the current task to the front.
> >
> > The plist was only to reuse struct plist_node pushable_tasks; in
> > struct task that is already there for RT
>
> So while plist makes sense for RT, it doesn't make sense for fair or DL.
> Notably for DL we keep pushable tasks in a RB tree.

I can use a rb tree as well my gaol was only to reuse the
pushable_tasks as those pushable list are exclusive

>
> > > So reserve iterating rq->cfs_tasks, skipping blocked and current and
> > > such, should get you much the same over-all.
> >
> > Yes but I was afraid by the overhead of iterating this list which can
> > be very long; We have already seen email about bug with thousands of
> > tasks queued on the rq
>
> Right, so just take one of the tail and stop there.

I don't want to take any random task from the rq but only one that is
meaningful. Why do you think having a dedicated pushable list like rt
and deadline isn't worthwhile?
