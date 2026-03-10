Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3A27FB05
	for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154338; cv=none; b=HsY1somRkDim6hXHsUwmhWYyK/qhkECzHdsoxROCPaLOviJb9EfpQ8/mDlXIxKZ6gQjLuptx0K+EcO69v8vinQZ+qL834+dVrexU524AjsWGOk2mjwOY6gK7e1e7oAk4mYCPXWc4nfzfe0jMgx74SfgsCpmOkIYF+0RQAYFySH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154338; c=relaxed/simple;
	bh=a2+6vOQFKrxwjUlberjXtjKa57WgxPQym0/ek2ddp3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vC1uag04d44qkJrdTV3o9WKTBiaaqadjhYCHh3XYR2XB8bq4i+6/fQRNSypfhPzk531p5cY9hgpvXskGiJQ6mmY9sqscqVUmCcugitbSsn0ol2ocTxL0/OexKrdn6K4xgJfUuAMLlab4qP+o5PmV6MUs8EedJGWvJOPxXE0+UKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=kHdh5vmG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="kHdh5vmG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so32553805e9.2
        for <sched-ext@lists.linux.dev>; Tue, 10 Mar 2026 07:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1773154335; x=1773759135; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2+6vOQFKrxwjUlberjXtjKa57WgxPQym0/ek2ddp3g=;
        b=kHdh5vmG85gDtnqhFb3vj5EmNQ+NBJt6sBIVv3582sKvVSYmgkXl1/KMwJlcb5mJ98
         kAxmFhpopMiRWZwcHTn3XXx82rmCDwQ/fTLKuZtpCAnwa6QHYLOuugyjVro4nbtsnO7V
         Rwvm9JWmWEh+TXYe2mIw3g5P5HcEYIWJ2p+179h5AawtvrHib/u0ESnydIWXLl0xNAVE
         HCouZ4Jo4yXG0rHacnL44rYKnMfpE3e/9YPrpXzhouQ8YKt0rydZ4EWp1/fXunYKFUFF
         7gfglIFDYePgIg+Ed8ZwCCswclbNQ8Pmsu3FB8mzK2T+QVl4rIeE62dDqFxwwWOfrJ25
         Gj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154335; x=1773759135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2+6vOQFKrxwjUlberjXtjKa57WgxPQym0/ek2ddp3g=;
        b=XsLSt9uPKl8zcliY140iodCZHaAZA6N4OUiWBRwYpSdRgqYWEpCBDmEkvEFEoSQ14U
         XJL3+RinyViWr3LzIkOLPvCGfOi2BK8JVr9WoncjCc2lLhFW8eAZejexxZ0Cze+8uN+0
         DV9/7M6umMx11kcY8+ZkJF98SA243vcg5fm3LK8cB4nAAhxiTs8B4Xod9IU4VK5REJCG
         3W68yLfowQI9zUfG94QdRRP/RImaKTiY7oSrqSep0ERqe9RlnwUkh5cGvZnYfnrB+Vs+
         H/njOX4CGGPXW4Hvea1fwSnyk/tfN3HaaavOxcUuXLWK9vRgwh8yck0k0sl3FqobasW5
         LBEA==
X-Gm-Message-State: AOJu0YzsJy73xpwl1MCfc+WQntv84n/PucbfiNed9lPb9xfohtb0nqCT
	clOPYj+vEtZlLv/nFzdu8YHVdQjCW764Hq3g6AsvWH5COm8MTitmQTg7rO5EYdLR21nNWRLZqU3
	nfAk+
X-Gm-Gg: ATEYQzzkNEBCoSq/lJpWT/668TV5OLmkdeUMQcRzgSwl8e54asNN/CH3P8cEUx2PI0I
	2SRgR+QoaH4OLrG8RcJFIm8F7MvSBJ+HqZ/yW7pCcnE5ZFu8KOwp24+XXtCN6Pgw179V3qwcPDu
	mcA1u/0w+F2bblHEwjeF5tNBDmHDyfr7xRITLaUYurkypQ/N0cY0ADWucMMbZI0fV/LXcO6/PS4
	dqXtplycsYjufp1lrvXXHMywDE7wZG5TjWicw3OczL5NQYV/Yb/bcNhR2jCXNLZ4MDhHyfNunla
	w+4bHhD44X+DSlMAYTgIHBpLoOLx6+2Dwh07N0WLih3X9bxj4XLp1xhmJQOWQ/9sD19kkMe6nMQ
	EB/Z+Tv0JKXD/XSnrxcogNx6E5QcdNuTzml4l9ZqF8cyMS5Rfy/XcOs6PO31zgzueHZOcnyu5hH
	RjF2x8/xv9K8CsuQp0HatkY3Q=
X-Received: by 2002:a05:600c:4686:b0:485:3ae8:2236 with SMTP id 5b1f17b1804b1-4853ae82538mr126830715e9.32.1773154335420;
        Tue, 10 Mar 2026 07:52:15 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::3d8:2f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae45786sm41385272f8f.32.2026.03.10.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:52:14 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: sched-ext@lists.linux.dev
Cc: kernel-team@cloudflare.com,
	tj@kernel.org,
	arighi@nvidia.com,
	void@manifault.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org
Subject: sched_ext: Partial mode priority and fallthrough to EEVDF
Date: Tue, 10 Mar 2026 14:52:13 +0000
Message-ID: <20260310145213.1060649-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

At Cloudflare we're experimenting with inverting the priority of the
ext_sched_class and fair_sched_class to allow us to pick SCHED_EXT
tasks to run before SCHED_NORMAL. This gives us better scheduling
decisions for those SCHED_EXT tasks where we can embed business logic
into the BPF program and prevents them being starved by the larger
number of SCHED_NORMAL tasks under CPU contention. There are a couple
of reasons we took this route:

 1. Our workloads are heterogeneous and complex and we can't move entire
 systems to SCHED_EXT in one shot. We want to experiment with running
 SCHED_EXT in partial mode as we progressively onboard more and more
 services (we run multiple services on single machines).

 2. There's no way today (AFAIK) to run in "full-mode" and have BPF
 schedulers fallthrough to EEVDF.

In an ideal world, 2 is what we'd want to do. Is anyone else interested
in this problem or currently working on it? Is there anything coming in
the future that would make it easier for those of us slowly
transitioning to SCHED_EXT?

Thanks,
Matt
