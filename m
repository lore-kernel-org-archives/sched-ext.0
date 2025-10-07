Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C852571BD
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830867; cv=none; b=MR6XTfxhAZxw5OfKyIB2CJSCdYY2eaaD3YKfcSjsyV3gdHgI7pD5Pp5ll6zW9Wf6qHzugONyZnT94NSjPHubjbFbqmtoKSPmO1HB6ysn0X/JHNrvH7B2xIdbCKr3F5aP6oiDSrzpryXwOIX4vgZeZ/NChbT+7YHK+8Sznf8TKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830867; c=relaxed/simple;
	bh=U/DiYplYwAEDQ0sSvEmC0Falh8sTDF6ELFWedBoYj5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LNNSvCRrbHp28DCRJV1h8HhZQ1yiataXay1jWP44Qcx83s/GNKEB/EGBXRzakJUeMphadDIungHCKYZ3PrV/nfwkCuZsaE5bwpHsr52SsnYie2fGJM/tYxuHt2MUA4n0p3sqIbAGtUG6Ax94k20fB8rXsAJcX5qzlOMRY88kAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsUHje82; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsUHje82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/0ukjdOyTbIVpXUnl0KJJD0YmKPrBUCxZHTQ8ntUf9E=;
	b=TsUHje82qK9IRbsPlH9+9YqimfgJ8qP99+w23CHjc4yJs7rrSVLLG2BZhNDi5qorPfcvIZ
	fApbWXiFwgQjBjE/wmbcrjAXuKP5MtODKAWdOO92uJyTmKn5GSQykwhsI1C6OdurZAuQMD
	SCLr/hBFRAaTYKRJBjm/BHQJIxJ5kPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-lEjF_CQPNWmPhe07E0-WKw-1; Tue, 07 Oct 2025 05:54:23 -0400
X-MC-Unique: lEjF_CQPNWmPhe07E0-WKw-1
X-Mimecast-MFC-AGG-ID: lEjF_CQPNWmPhe07E0-WKw_1759830862
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e38957979so22405375e9.3
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 02:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830862; x=1760435662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0ukjdOyTbIVpXUnl0KJJD0YmKPrBUCxZHTQ8ntUf9E=;
        b=gVPbMfqxSeBhwTOoKYchBhcBUlbZlHARrTZPVyZgAyPsg7wp0gysoXySuQRtgnjNdq
         gAAyiE75+YCgryHB4wFfBYIwFr4ZJzHv+tzUNzQdluZyLPiF2YWTRyNSapi3l+oYaW6Q
         JOAYRmp71GjU+CWgu6Aen3Gn2v1GAexfGZHatCsHwe/T3EmuhcICMGVbs1VmYUdNYt+P
         yy7/sDmDBNOFmK+bthBSyO5Onn2GE5PtMsCtOONClDB2N0m1E5EqNVpX9y2sasAzX3lV
         qN2WseSvyVhRFIPH9EWryCJik1bxORJSlW42Rjb4bvrB6r32YsitrIn5b4CgsGpo1aQf
         Epow==
X-Forwarded-Encrypted: i=1; AJvYcCVJxq0fNRNpdM7By+AtBxMUHNfS77cyKMj+L4viMJhRB+NYWHmM8Jsg+rQZxROmD8g1MAbe4fyh0D8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0sHBzrveNzXVbESBPRu5m0hNpW+Ed+3dIQw8EgX2pTJKgYajp
	9BR38dDFbRyFdt0wBeRi9YbJUn0RSp7Yl7AJjhllD2tzr1tyE6IExJQGfWRWknavbfCx9c+h6SG
	Oz7jaR58I49eonTU11Ue7K8DWsD6ovszWr/RqG3PZoQ/wGifydJIUYtB94VTttw==
X-Gm-Gg: ASbGnctOlIzH4F9ljUXUBXxoZpMVS4OblcGvcKWxNm3BRFBgPJf3DP1OXeY7uh/4sxQ
	VjIuS3TRgRwMkY3eVF45XfX9nSc48yCyZwkPia2en37EEe1z8y3Zt7F0O4apICfW3G7oih7pTu4
	2AvzvIQkLfC1OP9IFwSnCICvCTdxhCODcoX26/0TWKky9M0jaH/3xsy/JQuyVNbASyiSqUiMOxS
	em5lbvv8o+T8vC2mnuWSjJwf66Hd5xDL7G9RhTnA9FVDH9QQfBtU7K5RKlKu2XFVD2YSAuMYPsx
	Ry00b3SuapvK46En/hMP75X5KelvdVgFcLLcR5mwjHyrlHnT+1lEYQ3BlU8bYcNCpogxbTeP4J6
	Tow==
X-Received: by 2002:a05:600c:154d:b0:46e:6c40:7377 with SMTP id 5b1f17b1804b1-46f9bb3fd36mr47610685e9.35.1759830861050;
        Tue, 07 Oct 2025 02:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS0VPrl4ggx5+ULavzMXJENjXtwRIeiQWoxBnhFL2h5ZR3YiycuAomMDj1/PqSGaQ8uE5JBg==
X-Received: by 2002:a05:600c:154d:b0:46e:6c40:7377 with SMTP id 5b1f17b1804b1-46f9bb3fd36mr47610485e9.35.1759830860568;
        Tue, 07 Oct 2025 02:54:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723591fcsm197344675e9.10.2025.10.07.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:54:20 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:54:18 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 10/12] sched: Add locking comments to sched_class methods
Message-ID: <aOTjSla1Yr3kz7op@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.694841522@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251006104527.694841522@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UxTQcHxXEBuJ-IiLpus6qsapujx5d4-ozzxo3any1gA_1759830862
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

On 06/10/25 12:44, Peter Zijlstra wrote:
> 'Document' the locking context the various sched_class methods are
> called under.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

...

> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2345,8 +2345,7 @@ extern const u32		sched_prio_to_wmult[40
>  /*
>   * {de,en}queue flags:
>   *
> - * DEQUEUE_SLEEP  - task is no longer runnable
> - * ENQUEUE_WAKEUP - task just became runnable
> + * SLEEP/WAKEUP - task is no-longer/just-became runnable
>   *
>   * SAVE/RESTORE - an otherwise spurious dequeue/enqueue, done to ensure tasks
>   *                are in a known state which allows modification. Such pairs
> @@ -2359,6 +2358,11 @@ extern const u32		sched_prio_to_wmult[40
>   *
>   * MIGRATION - p->on_rq == TASK_ON_RQ_MIGRATING (used for DEADLINE)
>   *
> + * DELAYED - de/re-queue a sched_delayed task
> + *
> + * CLASS - going to update p->sched_class; makes sched_change call the
> + *         various switch methods.
> + *
>   * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
>   * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
>   * ENQUEUE_MIGRATED  - the task was migrated during wakeup

Not for this patch, but I wondered if, while we are at it, we wanted to
complete documentation of these flags. My new AI friend is suggesting
the following, is it very much garbage? :)

Thanks,
Juri

---

From: Claude <claude-sonnet-4-5@anthropic.com>
Date: Mon, 7 Oct 2025 12:44:13 +0200
Subject: sched: Document remaining DEQUEUE/ENQUEUE flags

Complete the flag documentation by adding descriptions for the three
previously undocumented flags: DEQUEUE_SPECIAL, DEQUEUE_THROTTLE, and
ENQUEUE_INITIAL.

DEQUEUE_SPECIAL is used when dequeuing tasks in special states (stopped,
traced, parked, dead, or frozen) that don't use the normal wait-loop
pattern and must not use delayed dequeue.

DEQUEUE_THROTTLE is used when removing tasks from the runqueue due to
CFS bandwidth throttling, preventing delayed dequeue to ensure proper
throttling behavior.

ENQUEUE_INITIAL is used when enqueueing newly created tasks in
wake_up_new_task(), allowing the fair scheduler to give them preferential
initial placement (half vslice when PLACE_DEADLINE_INITIAL is enabled).

Signed-off-by: Claude <claude-sonnet-4-5@anthropic.com>
Not-so-sure-yet: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/sched.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c222fa8f908..1a2b3c8d9e4f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2364,10 +2364,20 @@ extern const u32		sched_prio_to_wmult[40];
  * CLASS - going to update p->sched_class; makes sched_change call the
  *         various switch methods.
  *
+ * DEQUEUE_SPECIAL - task is in a special state (STOPPED, TRACED, PARKED,
+ *                   DEAD, FROZEN) that doesn't use the normal wait-loop;
+ *                   disables delayed dequeue.
+ *
+ * DEQUEUE_THROTTLE - dequeuing due to CFS bandwidth throttling; disables
+ *                    delayed dequeue to ensure proper throttling.
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
+ * ENQUEUE_INITIAL   - enqueuing a newly created task in wake_up_new_task();
+ *                     fair scheduler may give preferential initial placement
+ *                     (e.g., half vslice with PLACE_DEADLINE_INITIAL).
  * ENQUEUE_RQ_SELECTED - ->select_task_rq() was called
  *
  */

