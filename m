Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710468;
	b=Q7/NkEIyDBQjDz+dBIFX8gm+lnSRWQJN26zb0ArBk00ZGpYDd05yYDhsTqVgo1Iz6oy8
	 Y4QT/I/7Yg/YF8O6/cZlAJTvLu54c1RGMcMlWx1n2RHkIUZSbLK32e/OxSOxPryXD7nXI
	 /unaPBhqEWbW1wkiJuRe+EMkS66xDoGHKwmUoRLTsJ6/FyYxQO7nj8GCJkFiTo+hwsA6L
	 Cayj3HNHsDJLcZWxMd6Df5Udv5QkUcAdTpr/+dTD+aZhbtYiDyzuxkvpmcooZnnIphPHJ
	 6U57TRujKxQ1iIVoz3mBTIvWsdwCOv+yWP+2RZ+u7rzhs8uGIV89sPQ/B2gq14tsZ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/b7JOvQXXmoQ6+riyfmFa4IOM+ApazbsNDpOEn/4jwQ=;
	b=mfCI9yp+00ZeOBpypSyTNykPpcBo23dJl3RTvTh7NyDiv3PTddZjinidsk6iRTRw6oq+
	 iaqyV+2I5+fDsRWA2rC8hRpQK/CZeRSWNoaP+TAeX97/UBpKA07pRRUy6QWG5M7yR0oRS
	 kDGUtjqWxSfYR+GK06Mg+wB2wLsxgbEdaJ4/pr/ukdcLDFSFMmIPE1FusEbaPldQfo+kq
	 /AKnLkzU997t3ugZB/H3pGe2Prkbjw4ddowq4kwv9Oya0paCIhoNFlEgM6q1rzK3nVZyt
	 dOTrtvZWM8yxWCBdpsM5iGax3bXHSi5UrMXY1oe9JM/47VNMjS8SZUdSXFktnBWh0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nREdLpMq;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C232C606A31C
	for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 16:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C232C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nREdLpMq
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a070781f63so3493688b3a.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Nov 2026 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710467; x=1796315267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/b7JOvQXXmoQ6+riyfmFa4IOM+ApazbsNDpOEn/4jwQ=;
        b=nREdLpMqYtp9sIfRCE1+yIwiWsWu0rl3K3cl+rd1v25hxtWrbogvD/MSlm8NzLITeu
         0wQ+DkvlgBW2LLWsaALoUY/DgB6YUElXI4VV9Ff/EnV1C8yrQtUTFza9bFzkMoZ8u4ly
         OEo1aQN3gOPxgPK2PjBIdxx69eEIb2zC0j3YjWLUjsa17DTQwHEzuApu77hEfTFQzZNZ
         NX5p1XsROnbhcGVjzxcuy0XcBrl1WccWmqiKRsJ73RRYH76H5fjytopfQ9wjdDkfMcme
         0rIQ4cqQ3z//13Zx5YQqtzlLnkP2VBNQ8uZz0cXr/PPx6RhiuEbpZy2rAeBK/RpJzmV3
         Q7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710467; x=1796315267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/b7JOvQXXmoQ6+riyfmFa4IOM+ApazbsNDpOEn/4jwQ=;
        b=Mdh28Ef65khjhaFC4TinuOiOqTopmCfTX/DKRTlYK8Sjv561MQQtuRrm391+VOKfyR
         wjUfcAMehC1xmqeHl/bAt4urdmTAOB1uMIqDbzjk6bw4nDhKwmBILi1YaAEA2VEOlWWG
         cF5VMhSnGXA3IzX1MHBIcfWLVhvbtsMvIL5IQJLsRLVhYDPEExHIkxiiVIBYxnbnAAfo
         dH7gC+Q1qKpe8VT3HLa2gPopaqn9pgO5pQYqq0mvNcAEseGWK+eAm9KFTpmoS2AXGGbY
         vVRVrhaE3NRHRV53hf879PBEEZGNJmNH7dJSPTOZDxgF22Pq3tdn/1ipyynn1yIXu0pW
         xGZA==
X-Forwarded-Encrypted: i=1; AL+hErEKQt9rRaTBq6yckY2It2Np0xs8fTOFZgKDktFHm8A3oVFgRQ3wB/epEsirp0eNSlz5iHUHM7/I8gE=@lists.linux.dev
X-Gm-Message-State: APuU4Z/L0kc5FrzutmVRhOwH8Nu4C8rsx+2Hx/ipLb/cpiLYX4teWDN9
	695KHe9zlNgiDFvG131QSbd+3pXLO7c57VtN1MvGdr5fo+Y/J8wdalse
X-Gm-Gg: AZFdTZfAe390PvJ2G4Tot0b0dnSbni4XDCoXXo90nPf+J0/vQD58tZ8O0nG/kPviGvO
	DKwS1pvtiJrYtkj8aerUtNVtgWUOjcmNXmgwaAF7q/9Jm5Yd+LRMIOuOf6ZvNpsfKEHJe9KCKw+
	Z8fVrfTIz3o1CmP2XeVHMajzhHf3BaPaxxHu1Bly6pIx/VaKkvZgwy0rs58So4u8KlxT8nzdf5q
	n9xbp+4DY/znPrdeFuGglrvjVtFov/CvmDlqUdcKGi6SE1H2Y56op1wo1t8sBBkIceHZsISkFqM
	3NDuvNpEIse2NSDHIbiZ+oMXGjAuwGIAwCVqDnQVzYPUJCe9LX4BVz0PIy/rloBGh1l4+4BnJjS
	XomAlIv0DMwQ2beBhqP9NUu41hzPIXBHUAyDY9G9Zry7QfITNctKFDbmqkFZQkvWF9Xf6KO9eYF
	bNPIDxF22Pf2nwqscuu6nU28gIjihOCojZD79bisCaktlykDMhOsmjU0Et2+iJSQa2xMFzrseJI
	c9kbGQnoFUXRn+U/0XFbGY067Bn9U5wivABaCSAbchbxyjJZqwApZRkMFn0Hf3LIKhekH2DToip
	cQf4alSOieK4AX2mFv4OLCUXHhtsNBILggBTFyaT+vqql6RXmN1EDQtGxEC1jiRtW/5Xy8i0A4k
	R+i1fM+3gy75UinpyXo9FLExb61WZHeJlFQ==
X-Received: by 2002:a05:6a00:4405:b0:880:e4a7:b1aa with SMTP id d2e1a72fcca58-8c87daf2130mr20658095b3a.55.1795710466917;
        Thu, 26 Nov 2026 08:27:46 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-86-80.dynamic-ip.hinet.net. [1.164.86.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm11037097b3a.39.2026.11.26.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:27:46 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	Kang Chen <k.chen@smail.nju.edu.cn>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH 7.3.y 0/2] sched_ext: Backport two fixes dropped from 7.3.7-rc1
Date: Fri, 27 Nov 2026 00:26:56 +0800
Message-ID: <20261126162700.22257-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are 7.3 backports of two sched_ext fixes dropped from 7.3.7-rc2
because their rc1 versions failed to build [1][2].

- Patch1: factor scx_reset_task_fields() out of scx_disable_task()
		   instead of taking a298fd5f4ee8.
- Patch2: drop the __SCX_DSQ_ITER_HAS_REENQ context line, so 
		  b3768d058c98, which adds a new kfunc, isn't needed.

Build tested on 7.3.7-rc2 with CONFIG_SCHED_CLASS_EXT=y.

[1] https://lore.kernel.org/r/0782adf7-20af-45a3-a09b-2a34c76afbac@kernel.org
[2] https://lore.kernel.org/r/6e2e92cb-6663-457b-8225-0809917f4332@kernel.org

Kang Chen (1):
  sched_ext: make DSQ iterator stay drained after NULL

Rahad Bhuiya (1):
  sched_ext: Reset task fields on exit of an SCX_TASK_READY task

 kernel/sched/ext/ext.c | 57 +++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 18 deletions(-)

-- 
2.56.0

