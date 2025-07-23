Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2216815A87C
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272479; cv=none; b=LKS/qX85/KinzDPs5wFaBWk0jy4auOVfKreGalFnFh/ovL2Y5grUkHQ75O/sy1Mm5mhr9T03AriPzY1TlUpG/YeKR8Ag4ZJ4R7R+fL3P+vc1NPbrrCmOdaBi/K67isVPOI8h1tyIShbOHUIheltjrA5kX9lGfPLaqeRyZ6Z9sTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272479; c=relaxed/simple;
	bh=JfUhSBUF9/yE77aynpR6kRL5umEWcD9YnJR28JZ9/N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMykgSPYZ3Y81PvbjMsQcgBs6cZGuiMtC6TUXZ9ExzpKw/9XsuAsm098MzWQQ4pX6UuxOijUujflEOpFqBZMB/L/I6Qpz+Yza+kAYa5CTM56bNhS6ptLb5WJoyOGjdm5NwIBIvh759VL+IVLsbiENWsZh3IOk20PFaO4veht6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrZXLr6s; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrZXLr6s"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748feca4a61so3605965b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272477; x=1753877277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71iJ6o3Cy1WZwlH2o8+4IgfrhAkFwXPUCPsZF/BgD3U=;
        b=MrZXLr6sZaecWTILPq7geT40wDkhcg7IKAYHE8ofTHWHIMPHatzCZOK2Cjbo/APgMV
         PJFpSvVuqCRUER8oLkF8fNbJcDmNNAyEmdQ5XykzfTZ4SVf7b7k9S76Bx87DkUIr1ozm
         YM3e7nnI75a3A4EiHr8ntnE9bBBKl9ZEJMWwfY6RtiAewu23tcfn3Xf5UiFbHTTs8N33
         Y8v/ZDzcJiEr9akzMgQ75GUgrEiDnYjIDmY8QuU2Ok/JsyiIrs8wH/d1kO1tjx4e7+KG
         zvnpMvnay7YHhVnR5MDb8zWShUTDVtW743QJyeEfUG3w60Ky7ALWbRoUa1e90hwOVMwz
         +N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272477; x=1753877277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71iJ6o3Cy1WZwlH2o8+4IgfrhAkFwXPUCPsZF/BgD3U=;
        b=I0BHgwTnEEfbjbBPd4qrAJlznAXtm3Zdg8YW7f+zlVuHLb60zg3zjIzZHgB5pt820X
         fdWF7talBk4IThMjOQAj3PECLrgD2Gtww8paaSp1ogT5XytCtqPmNpw5UQ29INSiDIlr
         ChImts4IGGvO6wUVTCqim9xU34O8HYO3gc72IyLy57AU7NxP9sKOtb2sQw782gCkFeDa
         yeIIoG5gWILM0Nz+PulsX5MwXJdTO68NfmNBDACsOWsLNDG64ICO/P+BLBTZLr/yULE1
         v+6ZTmdHsuV4nCKF70E1yGl+Y8vZe0W2QJHDRmxlQ2r5v1UUNSIhQysU8MNwKyVMVyeY
         mQgQ==
X-Gm-Message-State: AOJu0YwB3ke9KJo66JAl75i68E/owCrntQXWt70KDdLxN/MYeiDzAS9T
	PvMAjc0Ryh5nOgTbXhtkpiWkDh6MGCLZ07jq9Rpau3o+nrbuAG6KKmhKCptqrbvhSQM=
X-Gm-Gg: ASbGnct8BrNhN4pr0guS708HIMVPYnmPDL2ZXKSRIH0dN0j36pukJGcm1jk3Zh8cco8
	1b5BGcXQ+9IgOTdaPdzdqJgsZhEp21wJnyPU+j1l/Zftnk85vwonKXEHM9Czq4uCmjO/mA7kgPA
	Ld+lyOKdSNqzyhUVc6jSoIv8qjOmUEsm4p3vjJ8KtgNBNflwE9yCdo77VSOAuDFIDcXeM3bHBvC
	7zNNp6ftCQQPOZSjzA7CE3b3806LKS3o/p5Dd5BqD74xo/ThWDEowpLe2QLQ47PMnrSuddc10qd
	ktAnuxnaGfc6ZLDplpmpdUoVOwcm0sXl37wmBtde0H79rnk5daTCVgisb7XW/TxWd3qV6RfCbys
	/4XVRrVuVlzjnq+r7E+zDKKSni68d0haHF5BcprGcfoU2k3joRffe
X-Google-Smtp-Source: AGHT+IG5R5538/C+4zz6G+4qX+xRUvzuz0xok3mAK9xeAsniZbUDkAZvhCJBOK7Z8LSr7vrp6yunJg==
X-Received: by 2002:a05:6a00:178a:b0:748:f1ba:9b0d with SMTP id d2e1a72fcca58-76034cececamr4241789b3a.11.1753272476778;
        Wed, 23 Jul 2025 05:07:56 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:07:56 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 02/10] sched_ext: Sync with scx upstream in tools/sched_ext/scx_central.c
Date: Wed, 23 Jul 2025 20:07:38 +0800
Message-ID: <20250723120746.52847-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723120746.52847-1-yphbchou0911@gmail.com>
References: <20250723120746.52847-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync via ./sync-to-kernel.sh /path/to/kernel/tree, as suggested by
the upstream scx repository.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/scx_central.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 6ba6e610eeaa..55931a4cd71c 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -61,6 +61,7 @@ int main(int argc, char **argv)
 	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
+	assert(skel->rodata->nr_cpu_ids > 0);
 	assert(skel->rodata->nr_cpu_ids <= INT32_MAX);
 
 	while ((opt = getopt(argc, argv, "s:c:pvh")) != -1) {
-- 
2.48.1

