Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E11531C8
	for <sched-ext@lists.linux.dev>; Sat, 18 Jul 2026 03:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344621; cv=pass; b=k2AFsMFOJBZjxwqhAQjvyOysTq3mbydenYqYPahSsGRNkH9m3abk9b1fUTwXHAzK1G1b+TewhnOyOqBKKETSIsXlOw/ql27CLBzeac3XzxMfo6lUp207CXR22a4RCXrINfYCEdB45Cb4rG28sSUrPGz90YTBAk9Wv1wfjV/UgVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344621; c=relaxed/simple;
	bh=KTdh5f5KlxeQfJtBl/PlJcz8iPQNnam7sIbNLiN7RTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJmZ/sKgA697pxw1vUFsUfcxp4kl+8OxZx6/mlshjI+l5oOVWPcnwiI1h4K7K/DBIvzVf3Q+YCn5xqu12oaTxfRXWkRP83YMwhr++HTn8Y2JgtMuvkpG2gpQ50SoBeOUou5zWg9H4N3IWY7QJGPdD0ABJ9rP+hDIDI6Fpqz2DKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGuCBGkP; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGuCBGkP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38deea72eebso6295094a91.1
        for <sched-ext@lists.linux.dev>; Fri, 17 Jul 2026 20:16:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784344619; cv=none;
        d=google.com; s=arc-20260327;
        b=KO0182UJPs4mJgkNFj8y0t0TEvkrGgrttobxE6sPLgGIFVQQE2X7l9b550uPEk/AVb
         HLKPfIBcr3hC8rmwNkiRC2bxewvyuDtp0FS0jlXLuO0dU+hP0L9pnLLekW/GxCoii2tz
         VFvEAi/4aEsvf4TYw7TDaIUSCvOFJETFiHm9mPS36/loOUvr1mFrsrUQxWoqXP9WwCgQ
         /OmRa2WK02He6Q0JrZIjnmI2f7PpTuV44M8TDxrgpzCC9ltLzfm0RHMIgSBhte9euVXT
         8T+9ZEhAC9cSzqDGbHAKvLFC+QykEiXO2RswGLXmMESMjaQYfFU51al/NDiS5wGAwswB
         Bfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZ5Yfd2MOhvr8+W527p+nLRkn+tveBVAVqvG26Bl8E0=;
        fh=h6lIv+UI0VTMKvmJ/VCYpPeRS+rTy30GMXQEfY8k5lo=;
        b=OQmo/12Tiqr6U3DSSyN3rnyO+SfmnPNT84tgdMrMpoZGul7U2RZ30/w72Nex0fgxtd
         Z2n2epPt9Mdcjsz0T3xPtxgZVx7yw5Kvp6jFBeX54VzL4g3zXnHqS3lwVVop5DN1zdNM
         JEXvmma9TFdrQBs09So8GdPtw3ng5QmApctJSQf0Vtbd2GvXjWLk1K6/uwBRN3+aAwpl
         LVTRbEd8KJqDRMbTMuNvgTXEFtmAkBpWP3ay/hKgNxXOG5jZb7Wth+Q0zOD4FVHTbpLR
         rLS74FH1vDj2amnJiJHGZBFTRZ6icTAM8JM6/14GHxVtqZrwpd0NdI5HS9XnShiGQdpE
         eGkA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784344619; x=1784949419; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aZ5Yfd2MOhvr8+W527p+nLRkn+tveBVAVqvG26Bl8E0=;
        b=FGuCBGkPtYt1qGOmh3PEmYMvn8APeU2WmRW+XyGJMbZf67GmWe5Dlr5ftL5sdu/JW8
         fe8iNNny0VUTUvoZTLhYmgXUMCAc/5nSYIw7oirGP11UbtgPE0fXT0YOfqXL7B6PiqQc
         27t5TEp4szRwgdQ/4nMBNW3oaWjv9ysXNY3lQPOTqknKmbcxSFw6C5fmGzYAz3zGM7Zi
         kz2BopEXNgwCC7+dyiGJFP3Kls/0tjbnrEpGRlOMCQCRtBjfOxnUxofpdoZP+PN6D7dF
         EQuuLnSFFIFXrkxdT2dBTfa9Gg5hml5FJCQ3mK/rugoon6BydM8RBgalpa0RD03HhKzX
         6uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784344619; x=1784949419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aZ5Yfd2MOhvr8+W527p+nLRkn+tveBVAVqvG26Bl8E0=;
        b=DX7jLUu5GbcjXcMVRJ8i4aMdLjL3oyRhcyKWl7n8lSu+gjOwYEvepFNH21VV+tgA6b
         PFhhL0Xp+q0IR1xYTxFDJasKS7UHTKP4w4XHQfLKeuog/TXXtbWnYPND1tvswHHTIB7o
         ekEY+JbACPscGwxqDKngHQjjl07tQ+N61O4LvvlUS3bPMehyi2YGSzwnrE68vi88Hf0Z
         DpeqwxvyIOX0GA6VG7fhN7R4rCtB3zdFvh4fw5IZ6c9vRnus4QYnS/GSFn0mSkHXrvVp
         sYCoHlrPUSwhpaerGB5ocqUASL3qu/HCHV/qOVFfoyISL2QPiBzGuGe69IO/Rek4Gp4x
         KwZw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1bkOuJ4BJF0k2NuI7CjV/uV7IW9WfbYX6BSb7XRQsUxfMUqOcLzVIn8Z1mNI6WkaSl33htKeHgjY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz225xuntOxPhKww+GsDnYIxrf5AIC7U6+53xxfcuHppG3iulpN
	MSi4fzEmKzr7WuY4RX8BBv0I65sJ1HkRI/+SUB99TNugY/c7u2mnU5yp10UcL/Zw0IJmLOblru5
	nS9yCWgyE/emylvWPz4P+4gNXPPC/9FeHqD4FJX4=
X-Gm-Gg: AfdE7cmv1q4/9QB3cYHvbB1bWMFSGhVHkuaG6BmOplTJzYnDLbM8vs25k6XLx4HQodA
	x2iM9/7fdWxMB3w0/tMew2viiaro5cNqEddU2bfgGpiv93Mha34+Z8Q9xM38esHRAdUHagUhZXK
	DcxiEuCPUXJHb7FciTQd/vojP8+SU/hYtaLVWz4ETGhIk5Iok6cvJeTV2QW7EOcRRSOyOWUaSrg
	/M7somZwh2ofDV7G3H6WzNk3wiMJlsi1Gh+v3lvHtII2x2nCBdz8G6ooYeGo9LalbmKJhe/KMXe
	usePAoQ0Hrh7PPUr9jeRQVVNsyPXnrFeuGm58v8nrIrb7CNo4sasLYQnAXbC071ZXdHythRhEEI
	eyNyd0GA7FBMnjFYTnsVjv4vB
X-Received: by 2002:a17:90b:3f85:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-38e4b479ecfmr5396715a91.19.1784344618889; Fri, 17 Jul 2026
 20:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716132229.61603-1-arighi@nvidia.com> <20260716132229.61603-4-arighi@nvidia.com>
In-Reply-To: <20260716132229.61603-4-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 17 Jul 2026 20:16:46 -0700
X-Gm-Features: AUfX_myu0qBjovMStvHPVKCtsLj-ROnUAzoFw3cIwPrmfx3P_LBAAY8vvsvIMao
Message-ID: <CANDhNCr33ZFdWHcMNU3QS4DiV36Vo_Kq1tP3uZBJXXEJEb4rnA@mail.gmail.com>
Subject: Re: [PATCH 03/11] sched_ext: Block proxy donors across scheduler transitions
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

On Thu, Jul 16, 2026 at 6:23=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Proxy execution retains mutex-blocked donors on the runqueue so their
> scheduling context can execute a lock owner. sched_ext cannot safely
> retain such donors unless the BPF scheduler explicitly participates in
> their admission and ordering.
>
> Make sched_ext reject retained donors by default. Force blocked EXT
> tasks through the regular block path in schedule(), and fully deactivate
> a retained donor before sched_setscheduler(), PI de-boosting, or global
> activation moves it into the EXT class. These hooks establish the safe
> default that a later opt-in can relax.
>
> This is a preparatory change to support proxy execution with sched_ext.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---
>  kernel/sched/core.c     |  5 ++++-
>  kernel/sched/ext/ext.c  | 44 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/ext/ext.h  |  6 ++++++
>  kernel/sched/syscalls.c |  3 +++
>  4 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e7827cffc2f0c..ddc832035854b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7173,7 +7173,8 @@ static void __sched notrace __schedule(int sched_mo=
de)
>                  * task_is_blocked() will always be false).
>                  */
>                 try_to_block_task(rq, prev, &prev_state,
> -                                 !task_is_blocked(prev));
> +                                 !task_is_blocked(prev) ||
> +                                 !scx_allow_proxy_exec(prev));
>                 switch_count =3D &prev->nvcsw;
>         }

This reminds me that since we no longer re-use try_to_block_task()
elsewhere, we can probably push the checks down into the function and
get rid of teh should_block argument.

But this is a minor cleanup for later, not an issue with this patch.

This looks good to me!
Acked-by: John Stultz <jstultz@google.com>
