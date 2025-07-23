Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A00E2E6106
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273280; cv=none; b=c79M1mGgrT3JbnRYKSrhdl2na87jH8YHSzRFi5D5BZnkNp3htphFn6uOZtsi9G7T4WENPjJEHunC75OVGZbHbGDIWDxBnXztrE07HVKjgw7GxF370bssGQD2XIZw5IRk7ZAITz/TQyb/DKzSX9JSM3z7SZaF5JHRIuyzTRAGCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273280; c=relaxed/simple;
	bh=QnO5oQ+zvAebBtSE2COZbJY+x529nNk90ry7bBoW3Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcZqKHl8ZEMcP6QH0jVZ0BXlMkerfz3DE6F/XCLGso6ZJraIZrdqjAD9z6zgAdYH5s4i5GfyWJuAp2vEw9cB2KLHqhq+9tSJAEBHT2+IDkQLntAiQ7y095bnW6VdNx/GRU0viBhIX2ILjHtq3jYhnBRsK7Eqv+l2tBUeqgnpWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hsn2IXES; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsn2IXES"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747c2cc3419so5289024b3a.2
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753273279; x=1753878079; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AT4G+vqyLfGlLtJ/c4fUnhwizEwBJpf7o1Ysyf3bbiQ=;
        b=Hsn2IXESPLCtD/zVwOh/cuS911cIyidZwiD4M3wchFnBX20OKQDcJXdnD444w9hwyE
         u1Q+oUNL7b5v9S6gaqPYH1yJq/4HsndO2ozQmrDStvYW7Qhre4wSYGh6nxCYllvQCKhp
         QeakF/J4iuMTsp5hVsaONoWerEZDOWWbzhZddBC/8DE8UVLViOumPkuijb1rsG5q8DB2
         G+chv4L077KOhhIno4idQuOjbwrbqKUkJOwBwWnK7XmFs/q4Suj5kuKeMpME8Rke53T7
         ExYb5GVLwYb+86AkhHMUI8/qsBy7+C0qhfLgFwT/A1iHWhNIKzAWVox9hDY4bqRjkkgi
         d+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753273279; x=1753878079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT4G+vqyLfGlLtJ/c4fUnhwizEwBJpf7o1Ysyf3bbiQ=;
        b=cWie0Fvo3n4EuanwVlmwA14pYHz164QaZ0Od6OTyllzF1VGAiE+xhzB4OnoLYToRp9
         TA2za9mto2KfJNEKe+sxnzeL05CvOw51e22ChRkUJeCvvfo3AWzAMIMVfKSNJR5Wvhjf
         jgcxGh8mB0E81g78nLTb5svyLZL0PaRHR3ieVqz7hyUgJ8bZokNXSZ86CCMmXthhlXEU
         58k/tIBihGzu9GwlkXNb/YgYTxlX40E9qrqw06Nz24yCgZIvq9icva+J/l9avKqAkVDm
         ZOiU1MQvectLFhrS/MhazsGnGQpAjwg7txb4i/vY58Gy+K5wAiEK6aPAdtRoB+MfHM0t
         ZVqQ==
X-Gm-Message-State: AOJu0YwLMjJsEzPC0rDepZ/s5oMdvH7el0QqV4VQSQPuKxiV2KE2xRLO
	aPOb4EiyIUSy7h+P+BnqkyFX5DdfF3aS7Z2E2GLDLa/x3lFof9xnUAF0Jjg3E+JlI1k=
X-Gm-Gg: ASbGncsJ5zI7dNR/OG3xDbTdR0gR5cK/a/aiZ0l1RCQ3sE7cYYajuxZf/OKvNIoj/cV
	ZJ17pCFOvjiuT2WLY/rIPfnYLjABVdmAorz96TBf/wNaUjyQnWui6AithXHx2NDZWZK5J7xH1Uq
	XWgAgZpV7gDRqiD7RR7+RVQxTAaArnNo5T3sw3uUZiRx63Eek9uukwQG2y6YLlkr+vc+RMtVyUI
	yAgTIw9YZtOx0fcjTgOvF2fYaRbn1OSFr1KCWrFCritnYQh86TfrIbEtF5hjcWwtKYhEN37IBmv
	o8eaQzh3FozmsR7YnzQAs5Uu0h3Ajt2mHgFlCHN4DLKc+fCMflP0nF7h0JWIGcB7whIjFap/u1q
	AhXqO/WGovbiptG7fyzM+eFgiDRnW6d+7vdZ1432b8CtYcQXcCze44DrzwHM=
X-Google-Smtp-Source: AGHT+IFTcxWFRcEonoBwc7qZUmjoppfhBaIeyKgUtd7k8lWEVqjq7x5Jipgn603zjkHOvXbUU3AzSQ==
X-Received: by 2002:a05:6a21:e8f:b0:237:b53b:64dd with SMTP id adf61e73a8af0-23d49027c4emr4609441637.11.1753273278649;
        Wed, 23 Jul 2025 05:21:18 -0700 (PDT)
Received: from eric-acer (36-225-72-127.dynamic-ip.hinet.net. [36.225.72.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8dc8fsm8889858a12.28.2025.07.23.05.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:21:18 -0700 (PDT)
Date: Wed, 23 Jul 2025 20:21:15 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 00/10] sched_ext: Sync with scx upstream
Message-ID: <aIDTuxIgPHL5Irap@eric-acer>
References: <20250723120746.52847-1-yphbchou0911@gmail.com>
 <aIDRpN7OZsz-uMju@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIDRpN7OZsz-uMju@gpd4>

On Wed, Jul 23, 2025 at 02:12:20PM +0200, Andrea Righi wrote:
> On Wed, Jul 23, 2025 at 08:07:36PM +0800, Cheng-Yang Chou wrote:
> 
> I don't think splitting the patch set into multiple per-file patches is
> very helpful for review. Since this is a single logical change, I think
> it's better to include all the changes in a single patch.
> 
> Thanks,
> -Andrea

Thanks for the review and suggestion.

I agree that this change is logically one unit.  
I'll squash the patches into a single commit and resend.

Thanks.

-chengyang
