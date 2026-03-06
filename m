Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EF306B05
	for <sched-ext@lists.linux.dev>; Fri,  6 Mar 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772790078; cv=none; b=Slnsz39wKA/ABC2r2/Ip1K21kcXVi7BB7aBQhO0pt3IcnIwvzZyzlRfJWn06Hh3XW+oZ4MZYS0w8bka96F61vAiJkhfUC7sT0aqiLQwpadJTkO2YJ9o5v/zNQEn5PaCaq3BnFw6fZpw/m9QEZf6eo0ZqK4rbMWfcx4llJ7QVORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772790078; c=relaxed/simple;
	bh=7q/qr3EasxGpK0KBXmkQggZVdN3yLD8iMA4rtNNF5qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osxp9hHdqZtwhGx73WKVXiHOFbf/0t/h/Nt8v+Ljc+2KezHCYCNw65zar8qJW1rFiO/gCE8Bq0kV56q2Gd9JrS2Fm3aQCh/NrbGQ5FskFOcPnsUfSiv/MVzfpB7hDQdkGGwQN2bcCojUdMvI91lMfxvfMzrfW0l31P7at2q4I50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpN+ct+r; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpN+ct+r"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829a9d08644so73705b3a.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Mar 2026 01:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772790077; x=1773394877; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H39b8OwxchQec01wzUpNEADaw8FiFONIgFr8aWEhBS0=;
        b=YpN+ct+rFlrC7ZrWqJHGx1e4xjZCMU+g8CELkKozcC48fpxiILx9orpfgsKw5ondId
         5ZJ6D0UMIGTgKWUzUQjb0W1kWqY5RktctZATK/kjFVlehExknYTEwUq8La3zwj+p5NUZ
         qe9yeMbDlFTZCX/UKv11DiZAzz7HoSmW8qiAUanRwSOCLkAijPzLzaL29TJJqPBDdxGj
         v1f6hEdeTxTcG7LKygHIMK006YmOyu++Ypf9Zt1btvJhVZFoKe5As2sXlTlnyJ9qtPuG
         guG+6OcPMrStbH92LPZDPPFkkyZztAn2Aq4YyfOEs/g+/VgKwux8Z3ND8oLQpXTGmIPQ
         fPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772790077; x=1773394877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H39b8OwxchQec01wzUpNEADaw8FiFONIgFr8aWEhBS0=;
        b=EuI7y0H+pNzHgSbWhZqG4faMrFPk0HzK8m1crE8POjXMEaTnIAMSga6GRjOPD4G/na
         NMO6rOQE2nmkWK2/N22Djgi23shHsjwd4GqkaF8vuo69FadLNbxZk5gi8KsNSpjD0iFE
         xCEmrhwxjNCPC4j1vyiT7t/MBU5NjFbXk03WNx6t5b407rNykuoHvrbr9ywqvPH2SIx4
         2FcWGI1lJ3rNxGZn/fieJGaxQqwwf4/scPg2MkG/bpDkD/HX06UdGZA5vu2J4NsbP09Z
         0rSTgtCk3mQECEXqksK0EBCcMUPwLLdq32ItJ8SoY66bxzewGM1iypHMzbyWDQekB70R
         8ljg==
X-Forwarded-Encrypted: i=1; AJvYcCVa+vSusrxnsocAnYW+7L9z+0hp7KXSCPmDJquWNwCE52WzG9eKWEc4yL5VkYciqiPGC0QZ8S+4mCU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyqWNI9lMUkuuMZHM/LIubTp1R2bM9vMWkBlFV1B++EYN7QuIBF
	KsZs9Cd5IDT19FrnENWS9oiuxMjey148+eK7ek8rBVu/bZhJJ+aabORu
X-Gm-Gg: ATEYQzwYQ8KgZwhOoLUAFvWe/WH2NArHuSswo/xeJFI4Qs8lPa+mZl6mFlJRiuJKFej
	FJzx0wxbFyrGUUmZaekMMVhqjrR5z+GSBexxx9HjiCAZeva5/hIMgCyZQrNMKgtM2ES2L3LDlWE
	dc/OEypFOtfV9/yL6OVdhfV2hMG9/I43cq2Ozan0J1Z6PBtksbeLlW2l4fKqxLZM8+Fc4e8Gigs
	vbiyAk5abRq1yTMnpDl8xq46Ju9h7UchGEuMIsHRk07tOKtcBpjg+ImcK22jk/ajCEnTH/TYhO4
	1obGuNqlCoOEIhGvCNL+q1OQCly001qwImm07pw8F+I2/7wWmqPe+kou6W5n7Ps41EOK9/l/wlW
	DZOMtDytaBpISnr+czF6KaEBS82enoJtOuPX06oXWmbCodCpvkJBUNXDQWvc4wz+/3BMU6lMb+d
	0xySo9cyc/TG5BzrnY7FSHy3Stl1wbr84DTl0eTtU=
X-Received: by 2002:a05:6a00:99b:b0:823:12cb:f5d1 with SMTP id d2e1a72fcca58-829a2d94f37mr1557363b3a.6.1772790076580;
        Fri, 06 Mar 2026 01:41:16 -0800 (PST)
Received: from eric-wcnlab ([2001:288:7001:1099:d8b4:9a91:beb0:3001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a54cesm1238731b3a.48.2026.03.06.01.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 01:41:16 -0800 (PST)
Date: Fri, 6 Mar 2026 17:41:08 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	emil@etsalapatis.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 29/34] sched_ext: Implement cgroup sub-sched enabling and
 disabling
Message-ID: <aaqhNHixAYT5kN_F@eric-wcnlab>
References: <20260304220119.4095551-1-tj@kernel.org>
 <20260304220119.4095551-30-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304220119.4095551-30-tj@kernel.org>

Hi Tejun,

I've been reading through this patch and I think I may have spotted a
lock leak in the abort: error path of scx_sub_enable_workfn(), but I'm
not fully familiar with this code so please correct me if I'm wrong.

percpu_down_write(&scx_fork_rwsem) and scx_cgroup_lock() are acquired
before the first task iteration loop:

	percpu_down_write(&scx_fork_rwsem);
	scx_cgroup_lock();

On Wed, Mar 04, 2026 at 12:01:14PM -1000, Tejun Heo wrote:
> +abort:
> +	put_task_struct(p);
> +	scx_task_iter_stop(&sti);
> +	scx_enabling_sub_sched = NULL;
> +
> +	scx_task_iter_start(&sti, sch->cgrp);
> +	while ((p = scx_task_iter_next_locked(&sti))) {
> +		if (p->scx.flags & SCX_TASK_SUB_INIT) {
> +			__scx_disable_and_exit_task(sch, p);
> +			p->scx.flags &= ~SCX_TASK_SUB_INIT;
> +		}
> +	}
> +	scx_task_iter_stop(&sti);

/* scx_cgroup_unlock() and percpu_up_write() seem missing here? */

>  out_put_cgrp:
>  	cgroup_put(cgrp);
>  out_unlock:
> 

abort: can be reached when assert_task_ready_or_enabled() fails or
__scx_init_task() returns an error during the init loop. If I'm reading
this correctly, leaving those locks unreleased would deadlock the next
caller of scx_fork_rwsem or scx_cgroup_lock() (e.g. any fork or future
scheduler load attempt).

Would the fix be to add before out_put_cgrp: :

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fd6e2173cefe..25d16d0f45d0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6389,6 +6389,8 @@ static void scx_sub_enable_workfn(struct kthread_work *work)
                }
        }
        scx_task_iter_stop(&sti);
+       scx_cgroup_unlock();
+       percpu_up_write(&scx_fork_rwsem);
 out_put_cgrp:
        cgroup_put(cgrp);
 out_unlock:

mirroring what err_unlock_and_disable: already does? Or am I missing
something that handles this on the abort path?

-- 
Thanks,
Cheng-Yang
