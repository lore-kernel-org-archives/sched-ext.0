Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEBE3EDE49
	for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874743; cv=none; b=b4sEOiD62dHpQckbtCr3OmPy2AwmzkVgSGHIimVqCdQLPldbPryVRw0/hgKFTfA3F+lHlsfnbt4kVclzroGHX6WyuHSmksunGS6yqYQv2HpVhrVR+5Pqjwi/1OqmviTnCF6YZonKBubP5Al3bosDjMDLzGo7LLuvx364mznZwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874743; c=relaxed/simple;
	bh=A1N9Y52zTiSYc1bbNxrS6CLuUh+j9rBK6m1Zr4M48iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jReU6ICAdJCleKkOhwMT4TZrjw023+sLN1Y4RoQ8dEApnFdCVRDxFZ+IPQo/SfskXfSpcjNL8D05h636T2L06c+ipto3MHqBwVgxBzTg0ophboS20TM6oHw3t9kxBbuksOcM9jEjXzL79MDARoAcIFqfjQsyqWjIwpItbAjWR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi3u0lbM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi3u0lbM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83975e992e1so4652895b3a.2
        for <sched-ext@lists.linux.dev>; Wed, 27 May 2026 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779874737; x=1780479537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS4tjMUUPzdQI9FfsCJLiT+3MeEnWLUL65FPiz1EwZI=;
        b=Qi3u0lbMPEYeBh716IjZAaM0moM/0NfpTNBLALBNiZ+jXVEEnRVnIOfDeUXOk1FYWQ
         PGsYbOYN8zbfHQqkWXJ6JWTYRHiWxuLPemfack8Lcq1LHfL4XiHP98dwjf7J0m8c4MTI
         Jrq+P0vXv2ewjowE4RAq6p9aL6pA2ScdoCELQG6xA8ZwvqXToFNkkWKOepORIcPGxF5l
         IpwPqm844DzRC3b1ml30HiU2lH1YHxnjs/wkmiQeikEp8V5Qdruvo9HYYWBd5LzhQY4U
         djIhHryiG6WM/AE1dsAxnJefsU+BxA2BXARF0QqKhvMT7xXRBuRfR/RYHMp1IdQ4Vx0Q
         XTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874737; x=1780479537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HS4tjMUUPzdQI9FfsCJLiT+3MeEnWLUL65FPiz1EwZI=;
        b=FWeXik7wnPuMGrZ7slQ2BGGECYouC3llBsjdexG+ixzJVWVXmaUtiC6XG3HJ7yunki
         ng7WzLRntF/JNta/yPGFZayQAvFOqo25wxNiAKFrAh4NdMoZaAP/ko9yMd1Ktypa3gIU
         qwJoDB8hpSPkdgmbdai5YeYuTyilnu+/w5vvKWxxprVZevgjlN+1zY+fSMmUv+EHtHS/
         nE//78lHh/3ru7QqQ9watOQtbENJ9PklvFsvpL6wHpCju4MbtalNgT+ONgC4PU91q9+M
         u9VvdKR/sMaTVLfZZdQKc3PL6XUwPiKhLnYCknYZLlLK6mIR9Oi/iIzOrU/T7Reh1uon
         CdUg==
X-Forwarded-Encrypted: i=1; AFNElJ/2HL+T4vP9ZX2P0j7Ex+sszySh+hysKxHkFfcbVHpyeM/pFheUKf88SOhEpG1XYe7dqCUTW8h40AE=@lists.linux.dev
X-Gm-Message-State: AOJu0YysIXePYlFUcMoou6jKvlNnOjZhlJIyB4S8C3ePvghOUJ0GPxKT
	X+HNTeJxNvdGdMt57wlc0MnYew591jWX7T4epsZAtzT2TX6pv7WZ1hTY
X-Gm-Gg: Acq92OHgFzcWmP/L7BTAEkavnL0p5rF/MouriyKcXFV7GLPNIXSJAQJNyWY7pFRQ+Gb
	zVErNpfyvlXRnYGW4pfxNVXSJ3INp7x/Q4We1Q2Y2owSo0DrV3nP/4em6u0Ryx5A0FAGC1Py6/A
	Y1BJk3Md+YHZjhBA21psrRocvxQ6J1f0lum1hnHjDrwRMPdRb5YhXpNrkGiebzRwAbEQ21ObK21
	sASjC63XCZM/q5FZrZMnKe0Rvgha7xH04Mh0F1NaU5jFCC01p/4dRKlTVUINsB4J5SMz6SN5L13
	SGijhxHYHTN6mzKc77JMyIVuYV9/bByJxnGm7HpQz2gRK36qCSmAJ8S2kE7Yfb5mA1e/UHTCTXi
	nPiiNDIqxWABtdrjlpsZ4qUVX72Ak0z356+wL0gcKrhEKO8yT04BXZyFONs3u0I0FKHSPlc9UIn
	1QNtIoUeNnfL//F4ARvLi3xFnMdbY0EvuHhnXyrfNQnF1AOIJKGBa0HA==
X-Received: by 2002:a05:6a00:2ea7:b0:82a:6852:559e with SMTP id d2e1a72fcca58-8415f3264femr21602701b3a.12.1779874736864;
        Wed, 27 May 2026 02:38:56 -0700 (PDT)
Received: from VM-0-14-ubuntu.. ([124.156.198.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d72f6dc1sm1900974b3a.51.2026.05.27.02.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:38:56 -0700 (PDT)
From: quzicheng315@gmail.com
To: arighi@nvidia.com
Cc: changwoo@igalia.com,
	emil@etsalapatis.com,
	enjuk@amazon.com,
	linux-kernel@vger.kernel.org,
	quzicheng315@gmail.com,
	quzicheng@huawei.com,
	sched-ext@lists.linux.dev,
	tanghui20@huawei.com,
	tj@kernel.org,
	void@manifault.com,
	zhangqiao22@huawei.com
Subject: [PATCH v2] tools/sched_ext: Fix scx_show_state per-scheduler state reads
Date: Wed, 27 May 2026 17:38:50 +0800
Message-ID: <20260527093850.3493647-1-quzicheng315@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ahXcAzxZbw6g_dLO@gpd4>
References: <ahXcAzxZbw6g_dLO@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zicheng Qu <quzicheng315@gmail.com>

scx_show_state.py still reads scx_aborting and scx_bypass_depth as
global symbols. Those symbols no longer exist after the state was moved
into struct scx_sched, so the drgn script fails when it reaches either
field.

Read aborting and bypass_depth from scx_root instead. This preserves the
script's current root-scheduler view: with sub-scheduler support, the
reported values are for the root scheduler and sub-schedulers are not
enumerated.

Fixes: 5c8d98a1b4de ("sched_ext: Move bypass state into scx_sched")
Fixes: c1743da43cf5 ("sched_ext: Move aborting flag to per-scheduler field")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
v2:
- Clarify that aborting and bypass_depth are reported for scx_root only,
  as Andrea pointed out.
- Add Reviewed-by from Andrea.

 tools/sched_ext/scx_show_state.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
index 02e43c184d43..446d82807f90 100644
--- a/tools/sched_ext/scx_show_state.py
+++ b/tools/sched_ext/scx_show_state.py
@@ -27,18 +27,25 @@ def read_static_key(name):
 def state_str(state):
     return prog['scx_enable_state_str'][state].string_().decode()
 
+def read_root_ops_name():
+    if root:
+        return root.ops.name.string_().decode()
+    return ''
+
+def read_root_field(name, default):
+    if root:
+        return getattr(root, name).value_()
+    return default
+
 root = prog['scx_root']
 enable_state = read_atomic("scx_enable_state_var")
 
-if root:
-    print(f'ops           : {root.ops.name.string_().decode()}')
-else:
-    print('ops           : ')
+print(f'ops           : {read_root_ops_name()}')
 print(f'enabled       : {read_static_key("__scx_enabled")}')
 print(f'switching_all : {read_int("scx_switching_all")}')
 print(f'switched_all  : {read_static_key("__scx_switched_all")}')
 print(f'enable_state  : {state_str(enable_state)} ({enable_state})')
-print(f'aborting      : {prog["scx_aborting"].value_()}')
-print(f'bypass_depth  : {prog["scx_bypass_depth"].value_()}')
+print(f'aborting      : {read_root_field("aborting", False)}')
+print(f'bypass_depth  : {read_root_field("bypass_depth", 0)}')
 print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
 print(f'enable_seq    : {read_atomic("scx_enable_seq")}')
-- 
2.43.0
