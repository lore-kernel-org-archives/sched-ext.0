Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238055;
	b=u4oQocGdI/qOH0hr8W3s2TlznbK2Iwsm+rVClwnAv/gN+6zrQ9BCGasPHQOXDM5+MZn7
	 OlM5v1AIVvQvnK/jwORBjqdrb3MGww6XpjcyKCPvCyOm/04Oh9HJKMGAoMzR0xkgyi0ck
	 sn82JCbSkxZRNYt92A1jem/qkibLm9fq6L5v8H6WG4B4qzUFi4tZbEa8bCUcHhDTopb+r
	 itBr30BK/qtW+CJQ0u9BaVLXgAWdXzgbszUH1DMZQgP8+/rEc/eQLCHD18Dy9np0ydeyL
	 xcgfcRJSirlh0Atd8YDVQ/x6om6jZyKoE/P1uQsAO8BSFDN6jpwO1foikHjBlNOUpbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
	b=EF5eial1zcR6DmPrBZjfQjlTv1IwPpEwaxwr969Ya9Gei09afkptd2pi54M+O/XRF1E1
	 jbdoe7s+J0HYFbRl14UzyIHAqr4jz9G92a4pLe4FVTeAsBDHEAZMpumwh4CsPxsMJ4NgF
	 WDGq9l+EIiHDstWiPcsHKUd7SfYX8NQd8Qruqtx321WfzB0UEGsu+VAe8/dpDDhMgXpwy
	 l2GQmWb2+yg67lfF217SW8G5HV8jyRtOHtM0PjbKH23a8aSG4RuHGDLjcMqWj3rLDcqai
	 /EDLMej67+j5wSk4Zr+VA3By6pwTHQzXG4Yed3VFzbaQDfLmyw2buamzeEawga99s0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M15WltpW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE86606A325
	for <sched-ext@lists.linux.dev>; Mon,  9 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE86606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M15WltpW
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a8cc11ac42so826720c88.0
        for <sched-ext@lists.linux.dev>; Mon, 09 Nov 2026 07:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238055; cv=none;
        d=google.com; s=arc-20260327;
        b=lm1+A/ZI0SO+IKv6xv4rZQCkBdMFps1tkfc0qTHnbXgiT5BYg8Mwusb8PLFE50Ijnv
         ttpwmTvmp7ho6B+Bc+sRgm01uFUrKz+Lv6xg3Vol4k+gu9TnpxyoP+T5oBTQwujSW9Pz
         MmMBX5kpSMfXC3RGvx5Tm7UfM80VAb7ABz5sUtrnpU/sPohFCQI6My7gRD+W7Lik61/b
         Wk0KH4kGvq56JVBP2WDjeb301AXl0Yc34tK9FiWrz3CiDxFU75XqnMAylcY2jkD36kOz
         TgbJeqKMFXAQAK/J8y2qR8cEnjdXWZP8XPKWbGMWcCdP9NJ4Gjq98wsNsI5zwbcRUyzs
         0Yzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
        fh=vFK7EHnK/Q1kLcMdecxoCApyqmtTQjQ9X0uPv8T5jcY=;
        b=CmCIu46FyZ/mlMShyJcz1GkiEOZjWF1Rk4SqOq1Ft7iFKyTISAgVE2eTAv1kuswO7N
         KpXBJGBttRSPxlKmJm5BOniDKj/x6c5ElbEtaOlHoD8mjG4PXQnCrUuushcWdWjARHg9
         Q47pof8N0MQ3T31rIx7kP7KzX2BAgbeXT1qljmaZY6xLaSBGcDBaFx2E/CHX6JkHiIHb
         Z3O63OLJJXeKEnShx72uyML9jcUGKb9h28yPmfJ68EGqBsXEEXzg0DAZo8SARk0RSM7Y
         Sc+bFW+3tpwxCnkqSVl/f4MH+uAQ/AG7RX/b2WBHV3OrL9GaKLw8fMbFIIu8DjSHbgUz
         oOhg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794238055; x=1794842855; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
        b=M15WltpWTMK57RvtCfpZ0t02cxKl14CaX6VcMH78Z+ct+a0WkQPAAQ4FuSBcIkr8/I
         9HhgevdiaGcy0Fylkbp/5HGIQgnLxfWbM7Z4V4p03RTjOvufAakd0A7+m5iF4MTls8t8
         Uh7ZHmyF16iADLgGqP7DLW2hGROShF+E/oQjlsAHJm/tPplkJj7jd2IPJW5plXimAT7H
         DsHvh7EYTKVKlTiw+YXMARlC6Ljm6Uui4bS92epCIZuSGmE1WXBx29oGotBcIvOu4X/A
         W8hKpydoRkkr9jo8DdbXXZRpX7bYx+2PZDsVl+oa6qQNAY0X94jag7OY6EWz85EIdo3A
         QLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238055; x=1794842855;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CkHUCom+pnwRgKBsSTRZm1uBXmondET4nnHsAW2LsKU=;
        b=fWQuYRHQpHC+2TA2S32thZrditOYCyWBB39ZdZNb2xjCqDUJDj/2cQuEyiNCf8paj+
         g2FcHF3M9mdlKu2An0A/NIof1zAMXJyWEOPrvi68VaUTBjqN3RPOzaEnOyKePBTLY8FI
         u9ALqYgVWNFeBgOhRKILkDjbP45cvNsY9CvjiiBX2A/Rv07Lbr8+XeQ6WGodXO5rfe7/
         IDjwsEsBWvgOLV+c7sqFO7ZqkZt5uiVNQHVL+CAG2+JRsz1TMhgA+zKEEcdCaC0y/bZO
         5OoU05Au7Bxr408CfwAoq5UrK9LUcR9VbnrUqzJf3GB4MrcZi0fJaYIlX6v1BOFl+In7
         aWAw==
X-Forwarded-Encrypted: i=1; AL+hErEocX6nV+6NFq0Mj4dC5XxJk3wCtPWV0sLyoYCf+886gHwR1Zl36dj9lL9QF9/JbP7CasYQAwSvJFE=@lists.linux.dev
X-Gm-Message-State: APuU4Z+PSJzp+ZHdUFamTWzAb1z9mnvJQ/4VfwnK+pepYqConMHzg8Fd
	exZQqnSBmLHQdyL7fH/uNBITmI+FBdjxX8yuZ3G5EAfZflghb/jwvOQVRJWPWnbUU9OojOj5278
	EgvqcaRHNUMa2q2wZRvt75yMHdv8c4a86t7m6vvS7sg==
X-Gm-Gg: AYBFou3pYA2osii/QKTL9qZZoCj/5tZvvuGshVCGQpJCVr/ajQyrI/l4/3H20uABBn1
	QoGIbbHGVlwiX8iqZjHIgzXxPMK2Qi5GPNEsijhgUB/59fP5fbQ2zumgrKvZqax6EP4PWkxKpzl
	XX8jf9+m2ITOO28kzkVEuw+5jqdNzjw1pkDNn091RTfS+voO4G6W1wnMMl64NLKD7Eu/Ag6YnQK
	BbvOViGQaHLV20/eAT6tOjYAa0Xc98NKO+HKeX9gseX09F3VcA5/+PKyBVCrebozUVZ6dm37b3n
	sIlfChaBRouYKRkdohQdYycuFmLfwzB8Pzxe+qQBySQAYbQrHtwhNG0NjkcfF8hgZ8Q3WPFoMXx
	F3Wo93sSLlSnNcKizgEM0wRjwsZbDEar8gnVb6NU0Z7HtbLs/oanSEyIANKdnV0wsBlqM3Z1dRP
	Hd4wPjgqC6eI4rTYk=
X-Received: by 2002:a05:7022:28b:10b0:1b0:430d:d81c with SMTP id
 a92af1059eb24-1b39feab6a4mr6840400c88.25.1794238054264; Mon, 09 Nov 2026
 07:27:34 -0800 (PST)
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
 <20261106151947.3991524-3-vincent.guittot@linaro.org> <au38gSTzmvPKmqWT@scheduler.schedules>
In-Reply-To: <au38gSTzmvPKmqWT@scheduler.schedules>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 9 Nov 2026 16:27:14 +0100
X-Gm-Features: AclHuK9Nrs4TS1OKNzgmtAWPa6RLxFRPHbepbecLp2IzICCD5FnYMRrJefiIp4c
Message-ID: <CAKfTPtDXo8_3tfXt=UH+BKyO1rJCWjRAVXjO5nFVHO1NBd8LyA@mail.gmail.com>
Subject: Re: [PATCH 02/20 v3] sched/eevdf: Reset lag at wakeup when prev CPU
 has been idle
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 17:22, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> On Fri, Nov 06, 2026 at 04:19:29PM +0100, Vincent Guittot wrote:
> > @@ -8376,6 +8383,9 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >
> >       dequeue_hierarchy(p, flags);
> >
> > +     if (!(flags & DEQUEUE_SAVE) && !cfs_rq->h_nr_queued)
> > +             cfs_rq->idle_seq++;
>
> This needs WRITE_ONCE, no?  3/20 uses READ_ONCE().

I hesistated to make it WRITE_ONCE but i concluded that it was not
strictly necessary because the READ_ONCE is only used to compare the
value but not use it for any computation or sync so if the compiler
wants to do any kind of optimization what we really care is : is it
equal or not ? so any intermediate value that we would read would be
ok

>
>
> Cheers,
>
> Kayra
>
