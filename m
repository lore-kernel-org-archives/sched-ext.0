Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1D1FAC4B
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830959; cv=none; b=KpZU30VC/SLOrhDw72UD7wPv3THtHvL/xsdfBAwl9wdrzd4KT/QxeC7soTL/XD9bM5ov2ZzreIaJfjXOKXbeacvDmn028QgoN79fF9VbhfADV4Sc3EHtwgw1ibx4qpgPbSv7TqBRu+21CkQItgcms8+yxnuWVLpouxyDEA6vFLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830959; c=relaxed/simple;
	bh=k2gXPRmtd1TD4nz3Ql3EKl6sRy1fMt/woCrNSVaMfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TaM341SkG9EYLbQQdBUP4QOz+EwAB3FBZk2DKdU7ksLWzAn7wEyY7hYg7GygW1tvHtSYZndfezKU8C5RU/q/176BMDIutIZ5HGVTa54+5CEdyTRexiQ9oNx0yN29gx78hkDYOLVBRpAJ+y3yQEcLSxb9kGdAmKNi840cv8I5qNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQxlaQOt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQxlaQOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759830957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Olcvv+e5CTouoj30ORBeriv/rIyq1XcOKkYrvtcS0WA=;
	b=DQxlaQOt6yGeLoHI4FJFLegYtMFZMZjpnn+u7uvz/FxP6ZAvk+WPqbrDXcdZoAiA/b3hue
	bvVJkZY5unfeXjPlZ7uCnHphUa9KfQFZ4AOxm4qd1nxqySnKfBPnZIR9b7lq3JeWZPeX2n
	zccguwia1cBnKRyUkTLdjT2WYBH1zmA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-6NJL2VOkOXSUT0bF_-XRtA-1; Tue, 07 Oct 2025 05:55:56 -0400
X-MC-Unique: 6NJL2VOkOXSUT0bF_-XRtA-1
X-Mimecast-MFC-AGG-ID: 6NJL2VOkOXSUT0bF_-XRtA_1759830955
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso17124005e9.1
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 02:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830955; x=1760435755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Olcvv+e5CTouoj30ORBeriv/rIyq1XcOKkYrvtcS0WA=;
        b=Pnyt8Y3hjGsYNvrTaLuy5JWxenqpCapWV+inSMNIPhvKZNJIp7TdwU18NyfK+aCtxU
         A9VQYrA4TEbC+QQyeIiG7bKDCeVUJO32S/b0q7sVbiwxzoMywpn+66TnHhb8287W8eYR
         ooK2la95dduILsn8O7+Ko0nzBudzDTjfSCQxsv9cl/8HDo6NZp/ifKaRbilkB+M0KyZq
         JggaiS9zBa3uhwgk0/nq9AFr6UghGD9phEHn+ATD2dBoS7JXWH2RnxkVQ2a7L3cuMVH7
         czEXPCFYDg89Aiy+0KNL7WZ4hMwkQ2RtGIUIyz6pR5ViLsRJhEwBxJayjjJh63OwDy+u
         /2jA==
X-Forwarded-Encrypted: i=1; AJvYcCW8BHWZf5HhmuISkgGyW49f4Gr/xlxfZxOB2z0KohO7tyzu0LF2dbZntQpkrTeHcAy6dT+pGpp7SQs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+sz0QAdqxUi+7i4tFMSZJlObt78YP50w/L/Om6Tsxpsilis0D
	WauGAinMmKMG+LSfowfnB+jmnk5BKfYhWem8QkMBhYBqTJCFxhQGuMjl0psH62qfFnpwdJf40Qi
	jRJ7Vpb9I1SN+Jv0NnUzv+jAsMEFpEs27jyC+FvDtxQv7397vLBZWwF7lrd+Bxw==
X-Gm-Gg: ASbGncsOw4FuscdyhrkXPTc0tT2E1GXu0lLPXMyFBPkh3omKdzUye9T6oW2QJAW9yLw
	opyn8gM/7OTzskAmA5/q2pboxdSEw7b5C34e50SgVYUBjUBzmwf05nFVqUvxwhrUkyPu8sR4xVD
	6u64VTE9PyX7+3BbenIEKU9n+TRuEpmOHFsagw7bfBOb9vYsJLcK32dEQt4JrmnXmMvYo7GXh4y
	1P7JPQxBRLT4w54VnlmZ13BSpGs2cwEabh6l4JlfVl38O63XOdFBtYmlmGYCgW14Fmykqu4hSh4
	QN0AvG4Qslf3vlF81573P7QbRzhX8dbCt/L5i0xqq+boXIRdEtA4UeC5VuxRBBSMTxaFI7sAYus
	B+g==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr13517275e9.4.1759830954657;
        Tue, 07 Oct 2025 02:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4OXSeLV/Yz7tujxNUfJFKucFJb4UstVFyNXz/DqV4md0An1W/DljziOCxTIGE8WujReEeTg==
X-Received: by 2002:a05:600c:6a07:b0:46e:74bb:6bd with SMTP id 5b1f17b1804b1-46fa2952c89mr13517065e9.4.1759830954210;
        Tue, 07 Oct 2025 02:55:54 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa39f3d7asm13615125e9.2.2025.10.07.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:55:53 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:55:51 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
Message-ID: <aOTjp9z3MNqTQrpD@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251006104402.946760805@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sss7l9YLA5ggF1tqaYkxdTkb3SYpB5Yyr96X02t-dUw_1759830955
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

On 06/10/25 12:44, Peter Zijlstra wrote:
> 
> Hi,
> 
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
> 
> I would like to queue them into sched/core after the merge window.

The set looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

For the DEADLINE bits also

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

