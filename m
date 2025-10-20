Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3B2E9EA0
	for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954075; cv=none; b=T6qgWwvaADcSnMA2FjwWhUDg4cupz6K1xTu7Xujd/o22Eo1UI8fQwnyVDjuGDn1NkjgWSxjQwLmMcDDUXK+W2y4xZBK5PtRQRqxosyx6JYXXyZ2YPS+bB94XFYHzi358C92C/yvk8WXNGIu8HfEqwbXO+ph/mA3PPQBAZIFXXRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954075; c=relaxed/simple;
	bh=EDh2hY7KcsoLCVNbqCrydEKfepj9ENE7y3LCCo74QDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j+dgIq3JPxJwnsM0OjNDM6N5QCgGy0+MO5Wy1K0D8R5SsQWoO2459eGiovvjwcb5pKam0nDEOKPBK+IU9X7/JuErL0ahPLKwcLL4FgS/Ce2ehm/9Fd2kZNJrRg9HZuW4JumHubyv4PIzGHFfJVktkisrUMnv6Gt52wRrG99kzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Awz5Rvp3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Awz5Rvp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760954072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOvPujFryMZ7+AgeMw1kh2ZO5Xa2du80EwXqsZUS+1A=;
	b=Awz5Rvp3QULdC7SQPh3zjaVMzJLI1sKMNOaAwVLl1ETAIf0Nn0sv+E78vilnx6qNBQ5a7G
	fTTpvzfpvN1o8jxb2dp1iLizuS9mUmIoAT7gciwOAuY+ujT8hSgqW1CXw3ATnuSunIH0P+
	U4+Z0d4vJYhjA5styGBlGYSabKJ1lRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-qpgQKM9MOu-AG0Li7XKfjQ-1; Mon, 20 Oct 2025 05:54:31 -0400
X-MC-Unique: qpgQKM9MOu-AG0Li7XKfjQ-1
X-Mimecast-MFC-AGG-ID: qpgQKM9MOu-AG0Li7XKfjQ_1760954070
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47106a388cfso18220225e9.0
        for <sched-ext@lists.linux.dev>; Mon, 20 Oct 2025 02:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954070; x=1761558870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOvPujFryMZ7+AgeMw1kh2ZO5Xa2du80EwXqsZUS+1A=;
        b=AlkBUzilLH1HRQh4IzOzRY9fLR4cJrkzM0yva11Cpq98f7m7EnwFYfjrXbtmfJyo9v
         6lpo501MOQo5HpxwPQHiN88J4ugsiJB/OMuTtr93oQuDqnhZdb8dZV86CWf+vqG+Wo7V
         CVoRte72qCXVtpbAm8CyXNy7M01iduMi60RtLJ8J7+kKVja5nWW1d7RCoPT172ZKO5zx
         eEK3KzqOtRqGbhgZz9tNzxuRms+UEwXUp3eWd9y9qKKrAJWs+rujm2j5fNDx3f7J2poF
         whxHHzoepyHIBGN2SJ3tUQyk25wdJPP+2VsucyfGb6yZnhNxVdwuSN0uUvaZm/GpdCB+
         nsMA==
X-Forwarded-Encrypted: i=1; AJvYcCW7FeplpNnPgtrvQ/wppVROsetuEliaYRY/FndPlk5RejFv5mNQW5U7iX1JK1E0J2v38FPeudjAWkg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzL7olQyVG23q9QV9mjoEW7oKiYsW33HoMTkdlfWuD8t95ccUtz
	MpeTTcD8poahbZlvqIQH5Jayk1XjHNH7xLvcccaanlvvg6S6Lj6/3+SiwSKmaezrqgsZBm5jwkf
	dzByBmsUmbGaSv5Eo+/Q4XOqvyH05gjskSIa5xu46TesMM8XMweeFVJeAkXVFJw==
X-Gm-Gg: ASbGncvToTM1wm3DAroD0+dQ5Fpr2hsRVHEdyX1iWfgg0HqNOIoOg7sE08ZwqMSX26F
	k8ulIPNq8ObtbUL0RmRxtNkDfg/ku7v+XMqbT9t6865GV8C0eU7niB9zdcEtRvkCuyHylCiFO1x
	OR5cxvK5sDiung7URSq8KFQJBKktrbz0g6J4cDsZ6vUAZDi0QIg92EMM3A2dR+wXehDrDR43Pvh
	8oM9XGYXzc4K4Y0dutaVqvvhFkIRxsshZZXlpTiXKoITqN67G6Hh4g/au4G5GP2JHZHMa3zzIPx
	7J13ccVdFECffu+rLTxJ8TSkEMU+GOQ84yiX737WRpOG518w0JbknrYlJM3Y1cxI2Yr59eJwm2b
	/YrauhoT3a7H1M+3MwlpVP/XSKHnDVzg=
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr98205595e9.33.1760954070232;
        Mon, 20 Oct 2025 02:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwQc8jHbyCjws7r+xEl2xJJIVq9zC6q6jCBAIB087YXtxrslD/Tbf+7AnvpKx9nVNS0eYmew==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr98205355e9.33.1760954069891;
        Mon, 20 Oct 2025 02:54:29 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442d9e8sm224260885e9.7.2025.10.20.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:54:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:54:27 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] sched: Add a server arg to
 dl_server_update_idle_time()
Message-ID: <aPYG0w4dYZIws9sr@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-6-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251017093214.70029-6-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wGrbOVHusntx7skyORNnyfuwPiCT7yhaKXSaXWz6diA_1760954070
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Since we are adding more servers, make dl_server_update_idle_time()
> accept a server argument than a specific server.

Nit,                      ^ rather?

> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

