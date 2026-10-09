Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EC34D0CD1
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544602; cv=none; b=XHGMUYjYUzbbj8ByuYWrUPqkbdGd/ZgBTJiuao3GcAm1YiUTf8TiDrP8oLfdbwR4Tb36SZCQmwFFypgBfRS+OvDpYl1eK5oZIL9iL/BzYaFZn3YlFmP2YxN+QIuiYBcfmrO63wGrVJXPRWR6oH7eeBFx+swKkCvV6J6+lw5ovtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544602; c=relaxed/simple;
	bh=7oNXmCayF+uoWO7ThUQwKuLtcd+yuCMSaHRdecbZ64U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1gj5UXGnYXfR9jB3cZhOEx/5xBci57afqp4MRLcYxGYNQ0dT4c8YuEFEc9KwEu3ue+dM2UOym6ncXu13ifKKacyuAFr+93HVCQfgZYlJ8JsZKo0uUeOCtjFH7IhG5dQ7Rg9N/Yc+DEp/gHqm2VrmeRMFZxHSEbZCT11bQAuiu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FukdtOpX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FukdtOpX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a172da1049so1181085e9.2
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791544591; x=1792149391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itsLuONkjBfdmzhzJnq5Bn90MLJfbhblfMvMLn4gNLU=;
        b=FukdtOpXBvOhrbJPyeAhHGFDmTsTTyL1KcRpf3FzMOA35vnYNiO3VFhPjkjYmGbkpF
         cjw8scvVT7+8+OTU3owljnuFz90FJydoJ00hTyTDjVBjbT6xy95Tss8Bbt7C9mVwLr3L
         WiwN9OX7VOWBPqdyFYZiRI2+i6o+xjoCUxMYt8179OO51F9hr73H2bJJ4inWpVwAVsyo
         hr1G8P+z2KXBwz/26qdzWYpGhI0ilkdg7kMEyJCRMu7wgZJaCYPFkghpu03JNzNHtBV3
         PRlS2l9N0evy9w+Avto6ZxnG/AMNCdYXK06ZjEzp1NQszV+aMvdQqj4gbOTqEp4EqRtt
         +Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544591; x=1792149391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=itsLuONkjBfdmzhzJnq5Bn90MLJfbhblfMvMLn4gNLU=;
        b=Xn/Qn2lKNSZIkBIkMSmXQBfKECHOO5btGt/vfnmjdi8Tgha5ys96iWRKgnumpxwd4R
         5R3pKBdNSkOyPKTA2FbmP56JVY3g9EoevnHdJ5vL1wG/5zklA47nLNlg7TFwL+O4QMx4
         8fXKjyuN3UEhfDCPmGR+FXoeIxvgwZ2JXjKXAyPLIZr4rAhJYhhGn43c619Jf4RUPVpU
         heeVoeULMEVMv3uGQCiWMvSXm8ufXGn57BlLYa33u/RG5H4tEaVUzYgdChaZejoSrju0
         oBS3N0SmmCL1sXT81+Beyou4mzTP4kn3maHEwqxndVW+vaL0E9FjXp2Bxv2woHH+Md+M
         noLw==
X-Forwarded-Encrypted: i=1; AKwUvBwKT5X4SorJNaBBS9p4uKtMI2vyhVIQIfXQV2Q0OsJvr+eGz2J0EG9kcFcWnB8TN0BVskRKfFPxVuU=@lists.linux.dev
X-Gm-Message-State: AFuF++nmd6m1+ZS+MCt/Y6InGKLq/4024LObg2WSEcXLS6TVFd5Zq7nk
	74fCIkoYl/G/vvAssVaXnN47xlsMUyEZMPEAZ/BShAukOBv6PrslNolD
X-Gm-Gg: AYBFou3aXP0IaKUtsRckcUMfutD0Psiej0zcnylinoa7NKWvaAcy2kYS2Dd0Uu0Y5mJ
	3AjBePZqGAi5bRWPTVuhHx7AzGCfsiseOiZ0yuMyrf+EVx453+WrbSFH48XYPOnReALkEpHxlFx
	aGal+wK4D6PAwy6PRxD4ZVXUjUvJBU9pxLV10libXfQDH3T45XpVMWMBts2sz5IF3oVg5oqVnK0
	+w0lbNx+x45IFb2FMA3GJ2EUtD96herAmqCopdhSU2fVDJ2nBDPTK/p5uTJ3MsXSNuNVvrscOmx
	qfb9g1K7t25Q5M+/ux8ewiaQUKQPEmkn0INzxSQ6SLizcqz6pfZVPyMZHKO5dGonDnQNJUKNaR9
	rkNDn5ACXS2CHOMUGotwJi1TXj94NTfaAoauqs+YVK8tg/Qz4eJwM5wfgqoPiZkxCzuVQpzg+vL
	QnD0G/u/LoKkJ3xRgTEqap3ZPmyA1R94etNT7PgrGm7+xj2bust7i5Z0A2Z548qQSvq0w/hLcVH
	SZ97Ok4UIuWUMXAFtc3NTNvZ+lEfSY=
X-Received: by 2002:a05:600c:8b02:b0:4a0:1973:f05a with SMTP id 5b1f17b1804b1-4a18e47e19fmr31556705e9.2.1791544590796;
        Fri, 09 Oct 2026 04:16:30 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18f3b43efsm46733545e9.1.2026.10.09.04.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:16:30 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com
Subject: Re: [PATCH 14/18 v2] sched/fair: Enable push task for preempt short
Date: Fri,  9 Oct 2026 14:16:26 +0300
Message-ID: <20261009111627.4861-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-15-vincent.guittot@linaro.org>
References: <20261002154415.2270586-15-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Enable push mecanism for the preempt short feature which is the
> 1st feature using it.

IDK typo count of 'mecanism'. It would be cool if I counted the typos I found in this thread.
They're so important. But, I didn't counted them

> @@ -3475,6 +3475,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
>  	sched_energy_set(has_eas);
>  #endif
>  
> +	if (sched_feat(PREEMPT_SHORT))
> +		static_branch_inc_cpuslocked(&sched_push_task);
> +

Well, as I checked it seems like first user of the push 'mecanism' can't be disabled.
This could be the correct behavior too tho? If we want to open it and do not let it
close even when PREEMPT_SHORT is false...

But I think you wanted to connect this to PREEMPT_SHORT, no?
Well if no, then well I have no words. If yes, I have.

I done a quick test, adding this line to here:

        if (sched_feat(PREEMPT_SHORT))
                static_branch_inc_cpuslocked(&sched_push_task);
       pr_info("push key count=%d\n", static_key_count(&sched_push_task.key)); <--- This

And booting up the kernel. Playing with CPU1's online status and closing PREEMPT_SHORT.
And...

[    0.967146] push key count=1
0
1
[    0.967146] push key count=1
[   42.408439] push key count=2
[   42.475103] push key count=3
NO_PREEMPT_SHORT
0
1
[    0.967146] push key count=1
[   42.408439] push key count=2
[   42.475103] push key count=3
[   42.562426] push key count=3
[   42.619255] push key count=3

This is a bit messy since it's raw, but as you can see even when we
close PREEMPT_SHORT this not decreases. It just stays on and grows over time.

That's what I'll say, maybe I'm missing something.

Thanks,
Kayra
