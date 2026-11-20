Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166315;
	b=VkmWHdzIPOmvZzYj/QsAnHrMwPV+ULwLLLG04b2CN9OmKOEeOjzbNwFzIcjPJJLjwvMc
	 4dUDAkWsVZTFZgL3N2ctAheNILpnpHjiO8zgq59LoCdCjTz6v9fxyyFnAZzrNGCyHsoli
	 V6J07JBao0Uu6iCJMzCxdmKIijxHFPT8j3Ada8X2UXZFHMewjI1Cq8z5WsFB+JY+BRLCh
	 n/PCINS5dXMpPDv47vuLTp8Yt8f4WDDrmVrXTQ6YZ60B7LA3zwEp+LFurvHw2NvMqXAGv
	 uzWGZXWCTdYfDW++F9LRu1vCrZ3oWDah46oHvmC3cwnA55sK+rZkJdKLSnsDQNfz+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166315;
	h=DMARC-Filter:X-UUID:X-CTIC-Tags:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=F8c0szBg9qBHwMYngo+k10AIndbBzGKinqqurrP/q1M=;
	b=T0RAPIkaXnahHWhjKAj7xj1aA1CwMewH0BMkppTXkaG3ymtO+H5Jnl/XerBfd7WbDs0J
	 55Bslfy40MQ/Vtp6n84gpRs/mtTSwMjIG2aypRGJ0UWMSbrRs9HXL9mFX/u9KBoavuPZk
	 NCKRX/MCypPP6FbFYuoJjuFMh0WyJ+BatXWrNmvw7ekSa59+nyPcVssz/dG2JVs6flyy0
	 hPJrOTOK/iDdrFESE3y5DBiKdWs13Z0AJnxRH7E9gUcQ01uxCtJ37fPBZQaoLpIZcPfdz
	 6GPcHRD99ANdmuT+0Mhkjs1byuSQCLofxtfLcFzsapzwevjYT7UHNdNGw7ztQZPsRag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9A606A326
	for <sched-ext@lists.linux.dev>; Fri, 20 Nov 2026 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 56812648e4c311f19a56ed5b684f684d-20261120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0a05b280-e42b-4f50-97dc-55faa032f0cf,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.19,REQID:0a05b280-e42b-4f50-97dc-55faa032f0cf,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:7db8b62,CLOUDID:b1673874644b880c8c8dde93e9a7f8fb,BulkI
	D:261119223002FMBWSIFN,BulkQuantity:3,SF:10|66|78|81|82|83|101|102|127|153
	|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 56812648e4c311f19a56ed5b684f684d-20261120
X-User: sunshaojie@kylinos.cn
Received: from sunshaojie-pc [(114.244.3.119)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1708704801; Fri, 20 Nov 2026 17:18:24 +0800
From: Shaojie Sun <sunshaojie@kylinos.cn>
To: arighi@nvidia.com
Cc: bpf@vger.kernel.org,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	sunshaojie@kylinos.cn,
	tj@kernel.org,
	void@manifault.com
Subject: Re: [PATCH] tools/sched_ext: Add "arena" BTF type tag to the __arena qualifier
Date: Fri, 20 Nov 2026 17:18:12 +0800
Message-ID: <20261120091812.968482-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <av_lQuuL5lgbW1BW@gpd4>
References: <av_lQuuL5lgbW1BW@gpd4>
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

Hi Andrea,

Thanks for the review.  I'll add the tag to the fallback definition of
__arena in v2 as you suggested.

Thanks!
Shaojie
