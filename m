Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBF19539F
	for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814516; cv=none; b=qEi1jiU7F2KvOINlcL0mvX4KxoSLVz4DaqaAZSDCsDRBchnRjsx2hyGor+mDTr89VlUaSWvPpHDM3i/SW8WeUYn+2L7qyOpy6EU+xGS83NoCawEj//rVt37nWp68Rb8vWnErCWuPYoVAjLfBWl4ZT2FNBha/OG/bvzJZ5bxwAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814516; c=relaxed/simple;
	bh=Dob3CFR6DCvWhrAFQ5iFGkDiY9AbjGTtgkUF+/K3rdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nZEWwS4LAOSqrFJJ+rpXMoWI3ObtiogO0WfBGXw8c4KdnhP3TxzjkrKZfz6GPBOkbZItCO2o3MrarhE5aPWSy0SgTRXBNTgZ2nnV1XzyHIzWKWRp8hFUq61iVTZUfCfVr2gB+otflWYgGOzckAW9b+VoJ8YIPmZ9WtaQRUQt08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drNoWJFw; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drNoWJFw"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82989744ee0so6205574b3a.2
        for <sched-ext@lists.linux.dev>; Tue, 17 Mar 2026 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773814514; x=1774419314; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO+QmbA5qsZoboHmI71eTMhe6u+8jZPlbtd93PdrHF4=;
        b=drNoWJFwIXYHhJ3AFIHBES2MLtoGrhXhFvEz5BfeJMaCay27WqE+hVBAnFwwCiomK3
         89DOou3a2nV9b3C4zUOWPJVXjKtZ2n3n2yDPVzyWLCofOKemKNI+rL/tLz7wuJ9Ntp08
         47hp5XkWn422ahnPW6XraWziROf/inXAzWpku5R5NATrxT2+jnvJnVz5U9I8YCQdroQz
         j7T2RD508F88gCMoAwOG9Wm4139HTXOQ4w+R+uEaNXbtYrUS0DeLiS6L1Ej2pdnp/63X
         6JsOM31khngE/o16QPKqio8yVWyxb9ViPvmLP874lhZbsGBOVrMndlmeDCHPo5bjwYUY
         4hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814514; x=1774419314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO+QmbA5qsZoboHmI71eTMhe6u+8jZPlbtd93PdrHF4=;
        b=PgdufnjBGye8ytzmWCO3WtXbSxLCt4J4iKhFy4AYlLKAMe7q9vtfWSzkpdAzUP2dpY
         oWkf10NCZwdctXoDB3jgUyN4VSeJKW2czwUbxldMOmuhD28ec62Zb24W2kCg3HbU2x5X
         80Cyhs4wy6/6C8X+xY9byQDqF0qjFXVery6NpYxSUeGsdl1VkSljJcX90/0XgGKk+acd
         R3eFL3P6gfQqvI3Khr85TYvgJZynerKZK86LoSZ9CuCXVbGTCmf4Oma2VsWSHA/v14tE
         YbP6T0IvD9UH8B3NMl26x7qn0tplUauqYaNsv/A2e/QY4PcU1D4sPIw4C7vgufRM6T0j
         GE0Q==
X-Gm-Message-State: AOJu0YwN0wnydr7i34xQMfvIZ9n40EXg4BmvYGQ7M9wywRK+QjOPr9dB
	S72yjnX3B9HBPEcpw4c8WACSIeHq/+jkNNlsN/OJils6tTqUOExTOgF8
X-Gm-Gg: ATEYQzzLec1QzvYi0X+5LnoRvrALTkJGzo1noWyJdLgT76+2qPn6ASB8ykSe7wUx1He
	KXtrs4aLe7V9uBLH1gTJVoq9xHIxT/Pe0eigVLBpkZ2YIZdMMeAhArlDraKnt2auNiu01gWSlRL
	nI7RZWgv0/f8u3FjlZw0NExwPO3dma4rcQvXfIaRA8I551YHhnoYccDyHGK4Oa1bza6iEahGFwt
	ctYqm5LTUwXrSxzVvrKR6fZQecPm2gkntY/OGytZzkg/sIvbbUKbAJBDpDeU0ZaHqRPOzyF/AvW
	ahyMsNcvkLNmuaVPsk9GY3TC+PI+gq3cYmFyaV0onOxDMtOcB4HjSVF2e17wlQBsgBybBYXlvH9
	GlZ7jumc3ZwzCHWNxAyjyFIpSkY3AoIPyrQOakh3fUCLvPwGPUyZrIw3pJs3Dnr2tkRpiCumN1W
	WH55p3AzaFol/PpR03A2xT0duCBjleauKwto4M0ZxU
X-Received: by 2002:a05:6a00:3915:b0:829:80bd:c0e2 with SMTP id d2e1a72fcca58-82a6af0cb73mr1979775b3a.40.1773814513115;
        Tue, 17 Mar 2026 23:15:13 -0700 (PDT)
Received: from SH-PF5NDYD6.Hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bef9a32sm1469330b3a.58.2026.03.17.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:15:12 -0700 (PDT)
From: Ke Zhao <ke.zhao.kernel@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ke.zhao.kernel@gmail.com
Subject: [PATCH v2] tools/sched_ext: Update stale scx_ops_error comment in fcg_cgroup_move
Date: Wed, 18 Mar 2026 14:14:57 +0800
Message-ID: <20260318061457.49988-1-ke.zhao.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function scx_ops_error() was droped, but the
comment here is left pointing to the old name.
Update to be consistent with current API.

Signed-off-by: Ke Zhao <ke.zhao.kernel@gmail.com>
---
v2:
 - Corrected the new function name to scx_bpf_error instead of scx_error.


 tools/sched_ext/scx_flatcg.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0e785cff0f24..c0574ff416c7 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -919,7 +919,7 @@ void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
 	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
 	s64 delta;
 
-	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	/* find_cgrp_ctx() triggers scx_bpf_error() on lookup failures */
 	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
 		return;
 
-- 
2.43.0

