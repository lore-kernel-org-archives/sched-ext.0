Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AA2868B0
	for <sched-ext@lists.linux.dev>; Wed,  8 Oct 2025 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931664; cv=none; b=HyxYD67PJQ+N4S4vIsf5zl2KBxBhd7QU/jqWvG/1R+0BmmNTYe14C0wOPBIlHDRBv1r53k3P0aTM3XqUMHjjo4cstj8DUeENMrHg7W/PvlPDOjHCPXt2dzW8DeLD9p0tB2bbUi4Q67qzWBGdip+Vkrh4d2vK1WOglcIT5cV2qZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931664; c=relaxed/simple;
	bh=Q2YXGjIR+rL8BrcfhhvKfyIjtqjvZ8rgOU/s92qDdFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmnmkN4CAwWeYK8WkbMrGdTHHphOINjxfsUzHd3asbJtqfsD5I4Bx/Z9QOYX92sXES5J7IDO8Fho8eCnkxnFczbjtERlnoRiShdcSwIBfhLrFSZyklbWTM62PNwdphsPhLzH+R/Di/oi+xov6XKMvkogO2IMelVSrGp2SPrNBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOIB6p9a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOIB6p9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759931661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wdnPFA69fVX6wV/RaP40yhmuIxfn43fw2JAle9ryo2I=;
	b=BOIB6p9aOtnRSdDUKW1S/EkmQkA+IcEVwgZAEWXF6Tw4X4HIW3WA2tpgcLyw4dfWfKUb+u
	d/SKIUSjo4X7wQVPZcgKBcP4Si4rvgHt65fwasBi800BjQNIuG1vFvtN2uqeYWGXOP4MLy
	zm4qwRNiGsNUcpUdadfFyCmwNrFFSQY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-myTEAEuCPSyRCD06o2fw1w-1; Wed, 08 Oct 2025 09:54:19 -0400
X-MC-Unique: myTEAEuCPSyRCD06o2fw1w-1
X-Mimecast-MFC-AGG-ID: myTEAEuCPSyRCD06o2fw1w_1759931658
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3efa77de998so4642292f8f.0
        for <sched-ext@lists.linux.dev>; Wed, 08 Oct 2025 06:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931658; x=1760536458;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdnPFA69fVX6wV/RaP40yhmuIxfn43fw2JAle9ryo2I=;
        b=sMCALxfAYD+9LhaONtScsqGJh5BRMikHiTdw0heWWLt6ySWZCakM1ys47bhxT0FcSU
         t+R7a7s3JmIeZgIBSiNv4KGy00q+/M4XcfnLMA/Z9sMI642wA8ZX1eEVQM91jbcQhT9Z
         Oq8ct3V6KMUC+y4LaalQ2o33HEMaSSl2evns5gnfqJjUT0H87laqUeq/e4nYKZlYmuXE
         oHVhO+eVAFGnCA+K4ul9SYqSWNzjnq5oUH4BdRho1Q9b7wAiGk7lkKpRkmFSH8cHhHng
         EY0XXrCtTBT+sXk+iqIet9rHD3CIhY5KwNNgTmWv/owmj5/lNkAQyylY4ElVpHdAXJz5
         QGLg==
X-Forwarded-Encrypted: i=1; AJvYcCVZHpyw4ZXK2WlqFqMhJh+QxOF+AFrBBDcpSFfZIu4k1OLntItfRpGogvEeVfsIH5nJbvjdKIH3hmc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4uqMwAa8qFv/8DMR3VxqKf9Esu4KBWXA/rz5lfa7wzfpDXU/P
	WQ3GXrnjtGjYMnjbmalopjM+LjHby1qSoH/hBZYdOa0dB8rnYgydSI7sVA5rHLgIztcJuSpnITz
	yYrFT/mWvQAR00qgUGDhSmIGfQpoWfrV3mYS93KWqeSwdnYccAeeZCA6Q2n0L+w==
X-Gm-Gg: ASbGncvOg4QwrP6pmzT0SeGoeOmPfWOfJy+t3wcvRVfaRVugWZp4vIKZYx8+1U7Am4k
	1/fD0qQak5sBohGVF/MTBuAuQC9BTMP4qDDzCYYfIPDb81wqLTpYblCCn1SX3BcB0JUbVaZzdNo
	XQNpA3uqC8tTBkRS/l1allQs8rgcQlJGPaSr0icWtm4I3BJo4DDJKvWPiRBmlfRGMwACeghvj0z
	j6FI6EejSoA2qO2RPgWXCFPWSPRQPqiip+rrLFCOabMoBrm9pUeBq5HeFegarsB+a89RXBCap6H
	fvZi852SqhtgBPclsI+eL/hqTivJnEC8aMT2iyfuFjYd6yRXbdqwSDmpArU0TiSBEVcZEImpjiy
	+r7gC62kfyoUPx60JvhrgrZiQYbJpTSg=
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr2172159f8f.37.1759931658008;
        Wed, 08 Oct 2025 06:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6pPCr5ooWIlJwPz5RcCzOYg/HVdYm9VLX5s4KNvCsNHbATSOR8rWb5OHNt2RclD3WmUKfOw==
X-Received: by 2002:a05:6000:208a:b0:3ec:42ad:597 with SMTP id ffacd0b85a97d-4266e7dff52mr2172132f8f.37.1759931657552;
        Wed, 08 Oct 2025 06:54:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm30003416f8f.18.2025.10.08.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:54:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
In-Reply-To: <20251006104402.946760805@infradead.org>
References: <20251006104402.946760805@infradead.org>
Date: Wed, 08 Oct 2025 15:54:16 +0200
Message-ID: <xhsmhbjmhh52v.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kiYUMOGOJ4PnKT7Ax8Ti_m8DcUSIOh7cxgab_iJ1WCs_1759931658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 06/10/25 12:44, Peter Zijlstra wrote:
> Hi,
>
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
>
> I would like to queue them into sched/core after the merge window.
>
>
> Also in:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
>

Other than what's already been said, that LGTM. It's good to finally have a
canonical change pattern... pattern? :-)

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

