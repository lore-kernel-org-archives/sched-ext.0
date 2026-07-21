Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F3341AB8
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610956; cv=pass; b=m4CK3z0HigUR+PeFbXbO7jwrSc/vu7iKr7vBFoBe9t4TS8ncvRk8SZ9+Zijd/QThKKiYRk0a8LeFw31Zt+HPA0VxdfrFsXT/ArkWYxyLobTHMMHPpf7brRnxyhHjFd4ouSBq3ieaVWDVgRDpsoeeFd1pX95jCDMiShImXV7YT5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610956; c=relaxed/simple;
	bh=0jk9bInoDu25NiayHbsZBdJbKyNxb32xjfDskdUovYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6wpDI3sgtYo/8JmSjOmhL0YDUBW30BPWA/VsVM3E8uboDtZ3+VB73FeNVtuGXLLpGG07NAvgWseWscdmxkO00GOhsEDBCkM4N4XOjQUA5MUhfVggdo0gvrXUnruD7kS82atsyCarXnDh5HzHhoaDL/+hGJ14HZIIDELS+rdobA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NVMIAOg/; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NVMIAOg/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so3245851a91.0
        for <sched-ext@lists.linux.dev>; Mon, 20 Jul 2026 22:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784610954; cv=none;
        d=google.com; s=arc-20260327;
        b=MN63eZjlxi6OGb5/fuJtOWxewl3L5Ib5TyA8iwguZgHyPyuQtKLrL8lv1ONYh7tKnf
         AsmvUKnsdIcBEuffimHhkxJT0Fd5cWurodpx0a7/yVIMWnwVXZlwGkXXOw5cYEENKDtG
         wBXwegXV6xAgsy+UsqbUL5nbRzq8/6wrco9zvjHC1T1BOKqjmAvkBjbl7jUkVK+VyaWo
         rKeqjB4YqInlgCA6u+CiGqnge+eurheGsEnhtLsVYrwcKMqZ1E6OY7eOyCRnMsV0ZWLh
         i4VPZ2lEDIoM4hnWp/nrEL0gsN3VBoiNwXUhb/s13war/B4m/WAy258jzkzb8iM4mXBY
         T7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lIowLjSSvo2mN+pfaLXgrpQeKpt/zxzLwrLYfK8swEI=;
        fh=Zuz8LIilMEBG4KFYkidDe97vTv5rablhP/7DIA/zQ2A=;
        b=hj1yNms4Q+iysQabnG5XR5oTfMb3RFLfg5r2FF7/oM1vna5A4s0Ie3dI5eeavaqbm2
         A5w18Mj8oKghT6NI7xpjf6LbQz1PIbS2fY01IDWri9XZkH2oUSwXhBNNJPsm/GhF0cwk
         lpJ2ftqXe8DUkY2tgMXpefg0jOhdOuOZNP0yJA3CXgYhmm0cxJfyXZ3yzaMndgGQKiq7
         OxsKNd6UtSFwMPF6hwM9NHph2OC3tFdd2HZgWMfS1DI83P303DYlcTl/Tach5UqjXQob
         2x8q6DmtI1XaJroAVTHS+UhEivNRXXbKYvUOvuhYlfy1iaaXQv54PlSgBIZEdb4FHYDb
         4kFQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784610954; x=1785215754; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lIowLjSSvo2mN+pfaLXgrpQeKpt/zxzLwrLYfK8swEI=;
        b=NVMIAOg/HL39A24y3Tf9mnOOaJUmdjyD0m7T2eEQ8xf60rIQvvNHNibE0bxJi6nCtc
         m0N+nuCYIRCbfFsdtbmFw3oqRX8gflVh8dYGuszknWKNRGdjEZUShT2+BJGPDW6C0Ap5
         61YslP3qHEIgATS5snc9EK9v8faBk81x+Ja0dB3uzibX7xj60NYDOI7rtjH9CSKwHHWX
         Jw4Ri79qxtUxg2cfLGtt4Pr8iuMo189q3lOUu9nXlpy9+7nq2SQXR0eQuC0zJz+GgtLy
         bf2DDx9ZrFVYteD3QJfmj5rwJUtE4VNdloxwBHVmGOpry8+mQXV9IaqfXG7U0HIrFd7l
         jqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784610954; x=1785215754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lIowLjSSvo2mN+pfaLXgrpQeKpt/zxzLwrLYfK8swEI=;
        b=f6aqNmBApqQzHFLNkJ2G+lb8mcips9B+HR4uuzlARycZJg+MRkEwhkF3USjm+TCUFU
         gD0EE1RjyZOC0e5zdCbla4W5sW7zTf3oi9yaqSUv3Ox0toUukYnhOwhanibnAnD8arzH
         qxNDjI9oSXtYRdVJRb/pUTCatimhUWIMQuaHMM3v0g00j8CQJ2S3gr0IihkEKfysRgiE
         ec5i1Zs54AprP1Fa0aaPUMbL+fUuK97GDRP/rq2AefRmoD1jZh/viykbyHoPZfIH0YAI
         KjgfD1kFR6phg6NdAU2nuWdRNXjn+W5A0ZDD2Q3SLAXlWuT0PhBU0JZXVIF+sz3UsuKW
         poMg==
X-Forwarded-Encrypted: i=1; AHgh+RrhxTS5s5hccR1wr+EAVRDMhY4CRwgtjzVsYuc4MuSqNoQcQPUYiyN1p8w++ZTVeYWfdi4Gefs5sXY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzyA13oFrgtCsnyajjzpbDZ6DIAsHj2HyxRpuAmhb1JB3ZTa+He
	7AE2wa01k8H288F/lkyPB4yFTByVlVlEgRAacYw97ompFw7HCTKb24lfkLY54ahzsELVfCXC57S
	bCK/Fr9EzClkPmV5W3KSfdar2PqhgoSwG7ZSU4Ek=
X-Gm-Gg: AR+sD12sTs6X4I29XsUgtiISmsdt0QFpdweWNGqNrqGN549PqzgXAh7F6FRNfEbaisA
	HlNVPl3V8swq9eNELcZEqpUie2P1+bxOsB7xmtxrsCBhyuYV28lIzqoCjdNFdYknD4HXXC+6pZg
	Sp+shc7erz9jmf0ABODxwzX2X0NH76PQddzpC6l1/M46jXCgN8arsKf4Ge0wcEn7Y0BU48YsCtb
	c+XQR+lFT18CN/BiVFv/7nQW4BjtblLGYtArVDDMiwAcPRrudm02t1cQLtRP/uZidYpbkTkxgX0
	WT1gnkhOYTeqa+i6KfBDSYMuOL8STZtUpI4Xv2PslWlYTxYgoIp3J0d9UGfeE6o8culPUeMfOGQ
	rri1GyKEBpPuhEA==
X-Received: by 2002:a17:90b:3d4f:b0:37f:bfcf:fdfb with SMTP id
 98e67ed59e1d1-38e4b562803mr15196393a91.8.1784610953539; Mon, 20 Jul 2026
 22:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-9-arighi@nvidia.com>
 <CANDhNCq4pijyx=h5mcqFji0hDQSOPDqkS7LdeYcUKNneX_wNsw@mail.gmail.com>
 <CANDhNCp01g3PN4=hZgCBLUn79_H++y8hyAr4RZP+C3MYckon7g@mail.gmail.com>
 <aluMWf5H936NXA0N@gpd4> <al5GZXcH7D0s3I5d@gpd4> <CANDhNCrKXY3pTcsK4bSdeMRyUPjzdB+FBwF9A+p-djQ0TxCirw@mail.gmail.com>
 <al77hBqrJlr1_4Qw@gpd4>
In-Reply-To: <al77hBqrJlr1_4Qw@gpd4>
From: John Stultz <jstultz@google.com>
Date: Mon, 20 Jul 2026 22:15:41 -0700
X-Gm-Features: AUfX_myfNjtSLkqG82TzE5OuAgtRclHX68DAQT6upfWWI4ZFv7TOdMbUxf9jdm8
Message-ID: <CANDhNCpk-9ABJDpcLWe87tmHKw4fYWsODH_OGM__5hNUnD=fiA@mail.gmail.com>
Subject: Re: [PATCH 08/11] sched_ext: Delegate proxy donor admission to BPF schedulers
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 9:54=E2=80=AFPM Andrea Righi <arighi@nvidia.com> wr=
ote:
> On Mon, Jul 20, 2026 at 05:37:29PM -0700, John Stultz wrote:
> > Though, looking at your patch stack, I'd rather not make my patches
> > under review a dependency for your patches.  Peter has not yet put his
> > laser-eyes upon my series so there's no telling how much rework they
> > may need (and it does have some subtle parts that I'm sure he'll have
> > feedback on). So just to allow your current series to be able to move
> > foward, would it make sense if I added your "sched: Distinguish proxy
> > activations from wakeups" patch to the end of my series?  It looks
> > like there's not much interlock on the rest of your changes (though
> > I've not carefully reviewed the diff from your scx-proxy-exec branch
> > as they are on different bases), so maybe that would just work and the
> > rest of your series could move forward?
>
> Sounds like a good plan! It'd be helpful if you could include
> "sched: Distinguish proxy activations from wakeups" at the end of your
> sleeping-owner series.

Will do! I've got a few more things to cleanup and get through
testing, but I'm hoping to get v31 out to the list soon.

> I'll move the combined version to scx-proxy-exec-sleeping-owner for testi=
ng and
> rebase the scx-proxy-exec series without the sleeping-owner changes, so t=
hat it
> can move forward independently for now.

Sounds good!

Thanks so much again for all your work here! Its really appreciated!
-john
