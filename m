Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AEC217F33
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910676; cv=none; b=QYhwuUUwtbMHTPMHREivxeCoVy3yABSfjw5c/OznZ164ZtOCbcTWRPo3Ghsk+td5nZJRm04+7Yq250YgWRHBxGxynbxPnfjWPxz9eegTx/zhOOfsrePd0U/xoSQEnthpjsTar/ZiVnHhJqfcBPIz7FuZHEiUeXdL55nvCK2R/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910676; c=relaxed/simple;
	bh=K1yuBMDpnPOt4/KeRFVE2CusvjBh1MGwKZHLk7xzD4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pjk8CunEPdITY5nvUvPy/LwaRcnrOXRbpSgUnGX/N+zR1Df65jLRHbK+aN4A1Liw13YvXTlPcRVWNwVwpp7Ve4cDfoAURllHersVWd7AOD7FqUNhHPdu/Yg6D8jjwbYiw4IZ4Fl667a46SgpxYSUSyqInhX8hGINyKp4QjzrNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EImzOxAg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EImzOxAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756910673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJy/79mHdukukK/k7N0QCn2psTcagRNxoMm4TPphiNQ=;
	b=EImzOxAgxq1zDlN9AKD0uA9MvS0l1WZvhxW9oSSSsS7Orj6yyR8u81NIdWB+Y19/kih7sb
	31R24ZW/IVaLlPIxq8Dwy1bDPZoI8aBfuiAPdUERvot7CHgddHsqzKfFnD0clblXEljyyD
	0Nv1vxIi3j0V76cFeSvY3G+ooUt2yRk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-VYUFTMcUNBiAsl51C2AeXA-1; Wed, 03 Sep 2025 10:44:30 -0400
X-MC-Unique: VYUFTMcUNBiAsl51C2AeXA-1
X-Mimecast-MFC-AGG-ID: VYUFTMcUNBiAsl51C2AeXA_1756910669
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so207405e9.0
        for <sched-ext@lists.linux.dev>; Wed, 03 Sep 2025 07:44:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910669; x=1757515469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJy/79mHdukukK/k7N0QCn2psTcagRNxoMm4TPphiNQ=;
        b=m2HFqdczlV4maKX2moJ3a/V8b+bAG3WAVHdZLoD7yWLx5MI355Hf9PUlojkuY9B3Bn
         RYHPMkEQsLmIpDbQQi7QoZ6pI4XjNVCnD3UyHUww8AivpW4o9oqe/sgiNuoqIHPoqPDI
         CIeJ337g+QSlsjUAwWbJq21Ov99666TQHeSqhy5dsn9j6wrxT2dm+Bk3yXsRzL5mOOra
         hSMZu6cf0wkwF+xnZs1kSc80EJMNfORJ7QA+ZRcAULwue2oUimEIevMf6sBVcRHAniSv
         ouXFF4z7mhXxIiVj6LpiB1JZ1j8gZWoyi7IF+Ew52TbOLJ2hVHmby1Ct8pxTdXYfr9a1
         fnnw==
X-Forwarded-Encrypted: i=1; AJvYcCXlPnVSrshvS+LbS3M8D+Lapjr9tPmh4SrVjZGCB0H+vzJ8htcVn6ih2L77iprHezLRVF73XyMNpBY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6eUkf702O4G7kVVv+swxU6jv4FyYyVAAsN+6UZxNs3NJzeuh3
	WDPrLYFQCz8gcDEwG7eShiAo1WGzk0AsKpVMkj2qLoGq4IRyr3aunnjo0fyurQF8jbQvj9Te8Mv
	VTjOdzS5IJqDf60y+IfXKx3kM34LD3kTqw48ntDA6adTtJpHDPwnF/CAvR0pzTw==
X-Gm-Gg: ASbGnct/g10Ysy9OUnY/aweGA96aT3t3mqbux6BxgliwNG4GLrkUY/Q7hMexmK+eqnr
	89I/8Xa+Q/oASj48NVN7rF9/dOIj0IDqn2ug1wJdvIOLUNcfoYd4EnOlAM+gEwspC7v4hqYjaR4
	MQRK0M70y8byqgxwqzOMR+X5rfB7/6QS6wMsB+SCU7daspc7lk2UyT4OnB/1twQKF7Qb/SMCkaH
	CwgH1gTJOtmgIH7F7ZKOfu1hfduB4Qa/nrUgRyNxpvqVtFKxquYV/h8KO8ywihVHoYTOXng+GOE
	YqMwr/oIMXIGu7/OBhj6cn5wMj+m8ceQsS49rbxbP7V3R63QA6NoEybd9ERmaYGKSCRWr9s=
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b855c0d3dmr110370945e9.34.1756910669125;
        Wed, 03 Sep 2025 07:44:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKbkCMZ4LvPme/EuBzwbZA95CEfK10pvDin+qYg4BSO4x2L+ewZWsEmuElBxgPinCjh7EOCw==
X-Received: by 2002:a05:600c:1e87:b0:45b:47e1:f5fe with SMTP id 5b1f17b1804b1-45b855c0d3dmr110370615e9.34.1756910668723;
        Wed, 03 Sep 2025 07:44:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm242270935e9.3.2025.09.03.07.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:44:28 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:44:26 +0200
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
Subject: Re: [PATCH 04/16] sched/deadline: Clear the defer params
Message-ID: <aLhUSknzOOOU3lKJ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250903095008.162049-5-arighi@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q3oCkkdcOzL_eNrzHPyVpqjxislpFFu9KxF72Z7-ucw_1756910669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> The defer params were not cleared in __dl_clear_params. Clear them.
> 
> Without this is some of my test cases are flaking and the DL timer is
> not starting correctly AFAICS.
> 
> Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri

